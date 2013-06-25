import sys
from numpy  import *
import matplotlib.pyplot as plt
import matplotlib.patches as mpatch
import matplotlib.pyplot as plt
from matplotlib.ticker import ScalarFormatter, FuncFormatter

import shared

transitions_file = {}

split_index = sys.argv.index("+")

grammars1 = [g for g in sys.argv[1:split_index]]
grammars2 = [g for g in sys.argv[split_index+1:]]

files1 = [g+'-timings.txt' for g in grammars1]
files2 = [g+'-timings.txt' for g in grammars2]

# load transition data. Each row is the list of trial stats per this one file

f, (plt1,plt2) = plt.subplots(2, sharex=True)

f.set_figheight(4.5)
f.set_figwidth(3)

# formatter = ScalarFormatter()
# formatter.set_scientific(True)
# formatter.set_powerlimits((-3,4))
# plt2.yaxis.set_major_formatter(formatter)

def my_formatter_fun(x, p):
	return "%.0f" % (x / 1000.0)

plt2.get_yaxis().set_major_formatter(FuncFormatter(my_formatter_fun))

# 1ST GRAPH
stats = {}
means = {}
nfiles = {}
for i in range(len(grammars1)):
	g = grammars1[i]
	stats[g] = loadtxt(open(files1[i],"rb"),delimiter=",",skiprows=0)
	means[g] = [mean(filerow) for filerow in stats[g]]
	nfiles[g] = len(stats[g]) # num files parsed for this grammar

m = 0
for g in grammars1:
	N = len(means[g])
	plt1.plot(means[g], linewidth=0.5,
			 color=shared.colors[g], linestyle=shared.styles[g])
	if ( g == "JavaRats" ):
		plt1.text(N-len(g)*20, means[g][N-1]-100, g,
				  fontsize=12, family="serif")
	elif ( g == "Verilog2001" ):
		plt1.text(N-len(g)*17, means[g][N-1], g,
				  fontsize=12, family="serif")
	else:
		plt1.text(N-len(g)*20, means[g][N-1], g,
				  fontsize=12, family="serif")
	m = max(m, max(means[g]))

plt1.axis(ymax=m*1.08)

# NOW DO 2ND GRAPH
stats = {}
means = {}
nfiles = {}
for i in range(len(grammars2)):
	g = grammars2[i]
	stats[g] = loadtxt(open(files2[i],"rb"),delimiter=",",skiprows=0)
	means[g] = [mean(filerow) for filerow in stats[g]]
	nfiles[g] = len(stats[g]) # num files parsed for this grammar

m = 0
for g in grammars2:
	plt2.plot(means[g], linewidth=0.5,
			 color=shared.colors[g], linestyle=shared.styles[g])
	N = len(means[g])
	if ( g == "C11" ):
		plt2.text(N-len(g)*24, means[g][N-1], g,
				  fontsize=12, family="serif")
	elif ( g == "C11SLL" ):
		plt2.text(N-len(g)*24, 0.40*means[g][N-1], g,
				  fontsize=12, family="serif")
	else:
		plt2.text(N-len(g)*24, means[g][N-1], g,
				  fontsize=12, family="serif")
	m = max(m, max(means[g]))

plt2.axis(ymax=m*1.08)

f.subplots_adjust(hspace=0)
plt.setp([a.get_xticklabels() for a in f.axes[:-1]], visible=False)

#plt.legend(grammars,
		   #loc='upper left' , prop={'family':'serif'})
plt1.set_ylabel('Parse time in ms', family="serif", size=12)
plt2.set_ylabel(r'Parse time in $10^3$ ms', family="serif", size=12)
plt.xlabel('Files parsed', family="serif", size=12)
plt.savefig('parse-time-stats.pdf',
 			format="pdf",
 			bbox_inches='tight',
 			pad_inches=0.04)
plt.show()

