package org.antlr.v4.test;

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.LexerInterpreter;
import org.antlr.v4.runtime.ParserInterpreter;
import org.antlr.v4.runtime.atn.ProfilingATNSimulator;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.tool.Grammar;
import org.antlr.v4.tool.LexerGrammar;
import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class TestParserProfiler extends BaseTest {
    LexerGrammar lg;

    @Override
    public void setUp() throws Exception {
        super.setUp();
        lg = new LexerGrammar(
                "lexer grammar L;\n" +
                "WS : [ \\r\\t\\n]+ -> channel(HIDDEN) ;\n" +
                "SEMI : ';' ;\n" +
                "DOT : '.' ;\n" +
                "ID : [a-zA-Z]+ ;\n" +
                "PLUS : '+' ;\n" +
                "MULT : '*' ;\n");
    }

    @Test public void testLL1() throws Exception {
        Grammar g = new Grammar(
                "parser grammar T;\n" +
                "s : ';'{}\n" +
                "  | '.'\n" +
                "  ;\n",
                lg);

        ProfilingATNSimulator.DecisionInfo[] info = testInterp(lg, g, "s", ";");
        assertEquals(1, info.length);
        String expecting =
                "{invocations=1, LLFallback=0, transitions=1, ATNTransitions=1, LLTransitions=0, lookahead=[1]}";
        assertEquals(expecting, info[0].toString());
        ProfilingATNSimulator.dump(info);
    }

    @Test public void testLL2() throws Exception {
        Grammar g = new Grammar(
                "parser grammar T;\n" +
                "s : ID ';'{}\n" +
                "  | ID '.'\n" +
                "  ;\n",
                lg);

        ProfilingATNSimulator.DecisionInfo[] info = testInterp(lg, g, "s", "xyz;");
        assertEquals(1, info.length);
        String expecting =
                "{invocations=1, LLFallback=0, transitions=2, ATNTransitions=2, LLTransitions=0, lookahead=[2]}";
        assertEquals(expecting, info[0].toString());
        ProfilingATNSimulator.dump(info);
    }

    public ProfilingATNSimulator.DecisionInfo[] testInterp(
            LexerGrammar lg, Grammar g,
            String startRule, String input)
    {
        LexerInterpreter lexEngine = lg.createLexerInterpreter(new ANTLRInputStream(input));
        CommonTokenStream tokens = new CommonTokenStream(lexEngine);
        ParserInterpreter parser = g.createParserInterpreter(tokens);
        ProfilingATNSimulator profiler = new ProfilingATNSimulator(parser);
        parser.setInterpreter(profiler);
   		ParseTree t = parser.parse(g.rules.get(startRule).index);
        return profiler.getDecisionInfo();
   	}
}
