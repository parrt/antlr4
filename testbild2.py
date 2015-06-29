#!/usr/bin/env python
from collections import OrderedDict

"""
This script uses my experimental build tool http://www.bildtool.org

In order to build the complete ANTLR4 product with Java, CSharp, Python 2/3, and JavaScript
targets, do the following from a UNIX command line.  Windows build using this script
is not yet supported.

You will also need python 2.7, python 3.4, node.js and mono (on Mac/Linux)

mkdir -p /usr/local/antlr # somewhere appropriate where you want to install stuff
cd /usr/local/antlr
git clone git@github.com:antlr/antlr4.git
cd antlr4
./testbild.py tests

This script must be run from the main antlr4 directory.
"""

# bootstrap by downloading bilder.py if not found
import urllib
import os
import inspect

if not os.path.exists("bilder.py"):
    print "bootstrapping; downloading bilder.py"
    urllib.urlretrieve(
        "https://raw.githubusercontent.com/parrt/bild/master/src/python/bilder.py",
        "bilder.py")

# assumes bilder.py is in current directory
from bilder import *

BOOTSTRAP_VERSION = "4.5"
VERSION = "4.5.1"

TARGETS = ["Java", "CSharp", "Python2", "Python3", "JavaScript"]

TOOL_PATH = []
TEST_PATH = []

BUILD = "build"

JUNIT = ["junit-4.11.jar", "hamcrest-core-1.3.jar"]

class Module:
    def __init__(self,name,srcdirs=[],requires=[],dependencies=[],usesmods=[],resources=[],skip=[],pre=None,post=None):
        self.name = name
        self.srcdirs = srcdirs
        self.requires = requires
        self.dependencies = dependencies
        self.usesmods = usesmods
        self.resources = resources
        self.skip = skip
        self.pre = pre
        self.post = post

modules = {}

RUNTIME_TEST_SKIP = [
    'org/antlr/v4/test/runtime/javascript/firefox',
    'org/antlr/v4/test/runtime/javascript/chrome',
    'org/antlr/v4/test/runtime/javascript/explorer',
    'org/antlr/v4/test/runtime/javascript/safari',
]

def module(name,srcdirs=[],requires=[],dependencies=[],usesmods=[],resources=[],skip=[],pre=None,post=None):
    global modules
    modules[name] = Module(name,srcdirs,requires,dependencies,usesmods,resources,skip,pre,post)


def download_libs():
    global junit_jar, hamcrest_jar
    junit_jar, hamcrest_jar = load_junitjars()
    download("http://www.antlr3.org/download/antlr-3.5.2-runtime.jar", JARCACHE)
    download("http://www.stringtemplate.org/download/ST-4.0.8.jar", JARCACHE)
    copyfile(src="runtime/Java/lib/org.abego.treelayout.core.jar", trg=JARCACHE)


def parsers():
    antlr3("tool/src/org/antlr/v4/parse", "gen3", version="3.5.2", package="org.antlr.v4.parse")
    antlr3("tool/src/org/antlr/v4/codegen", "gen3", version="3.5.2", package="org.antlr.v4.codegen",
           args=["-lib", uniformpath("gen3/org/antlr/v4/parse")])
    antlr4("runtime/Java/src/org/antlr/v4/runtime/tree/xpath", "gen4",
           version=BOOTSTRAP_VERSION, package="org.antlr.v4.runtime.tree.xpath")


def compile_goal(goal_name):
    goal = modules[goal_name]
    print "compile "+goal.name
    mycompile(goal.name,
              goal.srcdirs,
              [os.path.join(JARCACHE,d) for d in goal.dependencies] +
              [os.path.join(BUILD,d) for d in goal.usesmods],
              skip=goal.skip)

def mycompile(goal,srcpaths,dependencies,skip=[]):
    args = ["-Xlint", "-Xlint:-serial", "-g"]
    jars=None
    trgdir = uniformpath(os.path.join(BUILD, goal))
    if len(dependencies)>0:
        dependencies = [uniformpath(d) for d in dependencies] # need absolute paths for CLASSPATH
        jars = string.join(dependencies, os.pathsep)
    jars += os.pathsep+trgdir # we can also see the code we're generating
    srcpaths = [uniformpath(p) for p in srcpaths]
    args += ["-sourcepath", string.join(srcpaths, ":")] # javac says always ':'
    for src in srcpaths:
        javac(srcdir=src, trgdir=trgdir, version="1.6", cp=jars, args=args, skip=skip)

def srcdirs(*dirs):
    caller = inspect.currentframe().f_back.f_code.co_name
    print caller+" srcdirs "+str(dirs)
    if caller not in modules:
        modules[caller] = Module(caller)
    modules[caller].srcdirs=dirs

def dependencies(*jars):
    caller = inspect.currentframe().f_back.f_code.co_name
    print caller+" dependencies "+str(jars)
    if caller not in modules:
        modules[caller] = Module(caller)
    modules[caller].dependencies=jars


def tool():
    require(parsers)
    require(runtime)
    compile_goal("tool")


def tests(module):
    cp = [os.path.join(JARCACHE,d) for d in module.dependencies] +\
         module.resources +\
         [os.path.join(BUILD,d) for d in module.usesmods]
    cp = [uniformpath(p) for p in cp]
    junit(os.path.join(BUILD,module.name), cp=string.join(cp,os.pathsep), verbose=False)


def tool_tests():
    require(runtime_tests)
    require(tool)
    mycompile("tool-tests",
              TOOLTEST_SRC,
              [os.path.join(JARCACHE,d) for d in TOOLTEST_DEP] +
              [os.path.join(BUILD,d) for d in TOOLTEST_MOD_DEP])
    cp = [os.path.join(JARCACHE,d) for d in TOOLTEST_DEP] +\
         TOOLTEST_RES +\
         [os.path.join(BUILD,d) for d in TOOLTEST_MOD_DEP]
    cp = [uniformpath(p) for p in cp]
    junit(os.path.join(BUILD,"tool-tests"), cp=string.join(cp,os.pathsep), verbose=False)


def regen_tests():
    """
    Generate all runtime Test*.java files for all targets into
    runtime-testsuite/test/org/antlr/v4/test/runtime/targetname
    """


def clean(dist=True):
    if dist:
        rmdir("dist")
    rmdir(BUILD)
    rmdir("gen3")
    rmdir("gen4")
    rmdir("doc")

def build():
    for name in modules:
        m = modules[name]
        if not isinstance(m.requires, list):
            m.requires = [m.requires]
        for f in m.requires:
            require(f)
        if m.pre: m.pre(m)
        for mod in m.usesmods:
            compile_goal(mod)
        compile_goal(name)
        if m.post: m.post(m)

def all():
    download_libs()
    build()

def mkjar_runtime():
    # out/... dir is full of tool-related stuff, make special dir out/runtime
    # unjar required library
    unjar("runtime/Java/lib/org.abego.treelayout.core.jar", trgdir=os.path.join(BUILD,"runtime"))
    # Prefix of Bundle- is OSGi cruft; it's not everything so we wrap with make_osgi_ready()
    # Declan Cox describes osgi ready jar https://github.com/antlr/antlr4/pull/689.
    manifest = \
        "Implementation-Vendor: ANTLR\n" +\
        "Implementation-Vendor-Id: org.antlr\n" +\
        "Implementation-Title: ANTLR 4 Runtime\n" +\
        "Implementation-Version: %s\n" +\
        "Built-By: %s\n" +\
        "Build-Jdk: %s\n" +\
        "Created-By: http://www.bildtool.org\n" +\
        "Bundle-Description: The ANTLR 4 Runtime\n" +\
        "Bundle-DocURL: http://www.antlr.org\n" +\
        "Bundle-License: http://www.antlr.org/license.html\n" +\
        "Bundle-Name: ANTLR 4 Runtime\n" +\
        "Bundle-SymbolicName: org.antlr.antlr4-runtime-osgi\n" +\
        "Bundle-Vendor: ANTLR\n" +\
        "Bundle-Version: %s\n" +\
        "\n"
    manifest = manifest % (VERSION, os.getlogin(), get_java_version(), VERSION)
    jarfile = "dist/antlr4-" + VERSION + ".jar"
    jar(jarfile, srcdir=os.path.join(BUILD,"runtime"), manifest=manifest)
    print "Generated " + jarfile
    osgijarfile = "dist/antlr4-" + VERSION + "-osgi.jar"
    make_osgi_ready(jarfile, osgijarfile)
    os.remove(jarfile)              # delete target for Windows compatibility
    os.rename(osgijarfile, jarfile) # copy back onto old jar
    print_and_log("Made jar OSGi-ready " + jarfile)

module(name="runtime",
       srcdirs=["runtime/Java/src","gen4"],
       requires=parsers,
       dependencies=["antlr-"+BOOTSTRAP_VERSION+"-complete.jar"])

module(name="runtime-tests",
       srcdirs=["runtime-testsuite/test"],
       dependencies=["antlr-3.5.2-runtime.jar", "ST-4.0.8.jar"] + JUNIT,
       usesmods=["runtime", "tool"],
       resources=["runtime",             # all the runtime/* foreign code
                  "runtime-testsuite/resources", # some C# stuff is in the resources area
                  "tool/resources"],     # code gen, error templates
       skip=RUNTIME_TEST_SKIP,
       post=tests)

module(name="tool",
       srcdirs=["gen3", "tool/src"],
       requires=parsers,
       dependencies=["antlr-3.5.2-runtime.jar", "ST-4.0.8.jar"],
       usesmods=["runtime"],
       resources=["tool/resources"])

module(name="tool-tests",
       srcdirs=["tool-testsuite/test"],
       requires=parsers,
       dependencies=["antlr-3.5.2-runtime.jar", "ST-4.0.8.jar"],
       usesmods=["runtime", "tool"],
       resources=["tool/resources"],
       post=tests)

processargs(globals())  # E.g., "python bild.py all"

