package org.antlr.v4.test;

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.LexerInterpreter;
import org.antlr.v4.runtime.ParserInterpreter;
import org.antlr.v4.runtime.atn.DecisionInfo;
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

        DecisionInfo[] info = testInterp(lg, g, "s", ";");
        assertEquals(1, info.length);
        String expecting =
                "{decision=0, invocations=1, contextSensitivities=0, errors=0, ambiguities=0, lookahead=[1], " +
                "SLL_ATNTransitions=1, DFATransitions=0, LL_Fallback=0, LL_ATNTransitions=0}";
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

        DecisionInfo[] info = testInterp(lg, g, "s", "xyz;");
        assertEquals(1, info.length);
        String expecting =
                "{decision=0, invocations=1, contextSensitivities=0, errors=0, ambiguities=0, lookahead=[2], " +
                "SLL_ATNTransitions=2, DFATransitions=0, LL_Fallback=0, LL_ATNTransitions=0}";
        assertEquals(expecting, info[0].toString());
        ProfilingATNSimulator.dump(info);
    }

    public DecisionInfo[] testInterp(
            LexerGrammar lg, Grammar g,
            String startRule, String input)
    {
        return testInterp(lg, g, startRule, new String[] {input});
    }

    public DecisionInfo[] testInterp(
            LexerGrammar lg, Grammar g,
            String startRule, String[] input)
    {

        LexerInterpreter lexEngine = lg.createLexerInterpreter(null);
        ParserInterpreter parser = g.createParserInterpreter(null);
        parser.setProfile(true);
        for (String s : input) {
            lexEngine.reset();
            parser.reset();
            lexEngine.setInputStream(new ANTLRInputStream(s));
            CommonTokenStream tokens = new CommonTokenStream(lexEngine);
            parser.setInputStream(tokens);
            ParseTree t = parser.parse(g.rules.get(startRule).index);
        }
        return parser.getDecisionInfo();
   	}
}
