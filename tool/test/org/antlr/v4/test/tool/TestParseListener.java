/*
 * [The "BSD license"]
 * Copyright (c) 2013 Terence Parr
 * Copyright (c) 2013 Sam Harwell
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
package org.antlr.v4.test.tool;

import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

// TODO: this should be in the runtime; mv there once we rebuild test rig

public class TestParseListener extends BaseTest {
	String baseListenerImpl =
		"        public void enterEveryRule(ParserRuleContext ctx) {\n" +
		"            System.out.println(\"enter   \" + getRuleNames()[ctx.getRuleIndex()]);\n" +
		"        }\n" +
		"" +
		"        @Override\n" +
		"        public void visitTerminal(TerminalNode node) {\n" +
		"            System.out.println(\"consume \"+node.getSymbol()+\" rule \"+\n" +
		"                               getRuleNames()[_ctx.getRuleIndex()]);\n" +
		"        }\n" +
		"" +
		"        @Override\n" +
		"        public void visitErrorNode(ErrorNode node) {\n" +
		"        }\n" +
		"" +
		"        @Override\n" +
		"        public void exitEveryRule(ParserRuleContext ctx) {\n" +
		"            System.out.println(\"exit    \"+getRuleNames()[ctx.getRuleIndex()]);\n" +
		"        }\n";

	String lexerRules =
		"ID : [a-z]+ ;\n" +
		"INT : [0-9]+ ;\n" +
		"WS : [ \\r\\n]+ ;\n";

	@Test public void testSimple2AltRule() throws Exception {
		String grammar =
			"grammar T;\n" +
			"@parser::members {\n" +
			"    public class MyListener extends TBaseListener {\n" +
			baseListenerImpl+
			"        @Override\n" +
			"        public void enterFoo(TParser.FooContext ctx) {\n" +
			"            System.out.println(\"enter alt1\");\n" +
			"        }\n" +
			"        @Override\n" +
			"        public void exitFoo(TParser.FooContext ctx) {\n" +
			"            System.out.println(\"exit alt1\");\n" +
			"        }\n" +
			"        @Override\n" +
			"        public void enterBar(TParser.BarContext ctx) {\n" +
			"            System.out.println(\"enter alt2\");\n" +
			"        }\n" +
			"        @Override\n" +
			"        public void exitBar(TParser.BarContext ctx) {\n" +
			"            System.out.println(\"exit alt2\");\n" +
			"        }\n" +
			"    }\n" +
			"}\n" +
			"" +
			"s\n" +
			"@init { addParseListener(new MyListener()); }\n" +
			"  : ID  # foo\n" +
			"  | INT # bar\n" +
			"  ;\n"+
			lexerRules;

		String input = "abc";
		String found = execParser("T.g4", grammar, "TParser", "TLexer", "s", input, false);
		assertEquals("enter   s\n" +
					 "enter alt1\n" +
					 "consume [@0,0:2='abc',<1>,1:0] rule s\n" +
					 "exit alt1\n" +
					 "exit    s\n", found);
		assertNull(stderrDuringParse);

		input = "34";
		found = execParser("T.g4", grammar, "TParser", "TLexer", "s", input, false);
		assertEquals("enter   s\n" +
					 "enter alt2\n" +
					 "consume [@0,0:1='34',<2>,1:0] rule s\n" +
					 "exit alt2\n" +
					 "exit    s\n", found);
		assertNull(stderrDuringParse);
	}

	@Test public void testSimple2AltRuleCalledFromAbove() throws Exception {
		String grammar =
			"grammar T;\n" +
			"@parser::members {\n" +
			"    public class MyListener extends TBaseListener {\n" +
			baseListenerImpl+
			"        @Override\n" +
			"        public void enterFoo(TParser.FooContext ctx) {\n" +
			"            System.out.println(\"enter alt1\");\n" +
			"        }\n" +
			"        @Override\n" +
			"        public void exitFoo(TParser.FooContext ctx) {\n" +
			"            System.out.println(\"exit alt1\");\n" +
			"        }\n" +
			"        @Override\n" +
			"        public void enterBar(TParser.BarContext ctx) {\n" +
			"            System.out.println(\"enter alt2\");\n" +
			"        }\n" +
			"        @Override\n" +
			"        public void exitBar(TParser.BarContext ctx) {\n" +
			"            System.out.println(\"exit alt2\");\n" +
			"        }\n" +
			"    }\n" +
			"}\n" +
			"" +
			"s\n" +
			"@init { addParseListener(new MyListener()); }\n" +
			"  : a ;" +
			"" +
			"a : ID  # foo\n" +
			"  | INT # bar\n" +
			"  ;\n"+
			lexerRules;

		String input = "abc";
		String found = execParser("T.g4", grammar, "TParser", "TLexer", "s", input, false);
		assertEquals("enter   s\n" +
					 "enter   a\n" +
					 "enter alt1\n" +
					 "consume [@0,0:2='abc',<1>,1:0] rule a\n" +
					 "exit alt1\n" +
					 "exit    a\n" +
					 "exit    s\n", found);
		assertNull(stderrDuringParse);

		input = "34";
		found = execParser("T.g4", grammar, "TParser", "TLexer", "s", input, false);
		assertEquals("enter   s\n" +
					 "enter   a\n" +
					 "enter alt2\n" +
					 "consume [@0,0:1='34',<2>,1:0] rule a\n" +
					 "exit alt2\n" +
					 "exit    a\n" +
					 "exit    s\n", found);
		assertNull(stderrDuringParse);
	}
}
