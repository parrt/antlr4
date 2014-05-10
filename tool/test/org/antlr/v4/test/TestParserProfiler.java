package org.antlr.v4.test;

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.LexerInterpreter;
import org.antlr.v4.runtime.ParserInterpreter;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.tool.Grammar;
import org.antlr.v4.tool.LexerGrammar;
import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class TestParserProfiler extends BaseTest {
    @Test public void testLeftRecursiveStartRule() throws Exception {
   		LexerGrammar lg = new LexerGrammar(
   			"lexer grammar L;\n" +
   			"A : 'a' ;\n" +
   			"B : 'b' ;\n" +
   			"C : 'c' ;\n" +
   			"PLUS : '+' ;\n" +
   			"MULT : '*' ;\n");
   		Grammar g = new Grammar(
   			"parser grammar T;\n" +
   			"s : e ;\n" +
   			"e : e MULT e\n" +
   			"  | e PLUS e\n" +
   			"  | A\n" +
   			"  ;\n",
   			lg);

   		testInterp(lg, g, "s", "a", 	"(s (e a))");
   		testInterp(lg, g, "e", "a+a", 	"(e (e a) + (e a))");
   	}

   	void testInterp(LexerGrammar lg, Grammar g,
   					String startRule, String input,
   					String parseTree)
   	{
   		LexerInterpreter lexEngine = lg.createLexerInterpreter(new ANTLRInputStream(input));
   		CommonTokenStream tokens = new CommonTokenStream(lexEngine);
   		ParserInterpreter parser = g.createParserInterpreter(tokens);
   		ParseTree t = parser.parse(g.rules.get(startRule).index);
   		System.out.println("parse tree: "+t.toStringTree(parser));
   		assertEquals(parseTree, t.toStringTree(parser));
   	}
}
