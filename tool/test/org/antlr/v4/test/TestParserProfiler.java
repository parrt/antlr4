package org.antlr.v4.test;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.atn.DecisionInfo;
import org.antlr.v4.runtime.atn.ProfilingATNSimulator;
import org.antlr.v4.tool.Grammar;
import org.antlr.v4.tool.LexerGrammar;
import org.antlr.v4.tool.Rule;
import org.junit.Test;

import java.util.Arrays;

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
                "INT : [0-9]+ ;\n" +
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

        DecisionInfo[] info = interpAndGetDecisionInfo(lg, g, "s", ";");
        assertEquals(1, info.length);
        String expecting =
                "{decision=0, contextSensitivities=0, errors=0, ambiguities=0, lookahead=[1], " +
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

        DecisionInfo[] info = interpAndGetDecisionInfo(lg, g, "s", "xyz;");
        assertEquals(1, info.length);
        String expecting =
                "{decision=0, contextSensitivities=0, errors=0, ambiguities=0, lookahead=[2], " +
                "SLL_ATNTransitions=2, DFATransitions=0, LL_Fallback=0, LL_ATNTransitions=0}";
        assertEquals(expecting, info[0].toString());
        ProfilingATNSimulator.dump(info);
    }

    @Test public void testRepeatedLL2() throws Exception {
        Grammar g = new Grammar(
                "parser grammar T;\n" +
                "s : ID ';'{}\n" +
                "  | ID '.'\n" +
                "  ;\n",
                lg);

        DecisionInfo[] info = interpAndGetDecisionInfo(lg, g, "s", "xyz;", "abc;");
        assertEquals(1, info.length);
        String expecting =
                "{decision=0, contextSensitivities=0, errors=0, ambiguities=0, lookahead=[2, 2], " +
                "SLL_ATNTransitions=2, DFATransitions=2, LL_Fallback=0, LL_ATNTransitions=0}";
        assertEquals(expecting, info[0].toString());
        ProfilingATNSimulator.dump(info);
    }

    @Test public void test3xLL2() throws Exception {
        Grammar g = new Grammar(
                "parser grammar T;\n" +
                "s : ID ';'{}\n" +
                "  | ID '.'\n" +
                "  ;\n",
                lg);

        // The '.' vs ';' causes another ATN transition
        DecisionInfo[] info = interpAndGetDecisionInfo(lg, g, "s", "xyz;", "abc;", "z.");
        assertEquals(1, info.length);
        String expecting =
                "{decision=0, contextSensitivities=0, errors=0, ambiguities=0, lookahead=[2, 2, 2], " +
                "SLL_ATNTransitions=3, DFATransitions=3, LL_Fallback=0, LL_ATNTransitions=0}";
        assertEquals(expecting, info[0].toString());
        ProfilingATNSimulator.dump(info);
    }

    @Test public void testOptional() throws Exception {
        Grammar g = new Grammar(
                "parser grammar T;\n" +
                "s : ID ('.' ID)? ';'\n" +
                "  | ID INT \n" +
                "  ;\n",
                lg);

        DecisionInfo[] info = interpAndGetDecisionInfo(lg, g, "s", "a.b;");
        assertEquals(2, info.length);
        String expecting =
            "[{decision=0, contextSensitivities=0, errors=0, ambiguities=0, lookahead=[1], " +
              "SLL_ATNTransitions=1, DFATransitions=0, LL_Fallback=0, LL_ATNTransitions=0}, " +
             "{decision=1, contextSensitivities=0, errors=0, ambiguities=0, lookahead=[2], " +
              "SLL_ATNTransitions=2, DFATransitions=0, LL_Fallback=0, LL_ATNTransitions=0}]";
        assertEquals(expecting, Arrays.toString(info));
        ProfilingATNSimulator.dump(info);
    }

    @Test public void test2xOptional() throws Exception {
        Grammar g = new Grammar(
                "parser grammar T;\n" +
                "s : ID ('.' ID)? ';'\n" +
                "  | ID INT \n" +
                "  ;\n",
                lg);

        DecisionInfo[] info = interpAndGetDecisionInfo(lg, g, "s", "a.b;", "a.b;");
        assertEquals(2, info.length);
        String expecting =
            "[{decision=0, contextSensitivities=0, errors=0, ambiguities=0, lookahead=[1, 1], " +
              "SLL_ATNTransitions=1, DFATransitions=1, LL_Fallback=0, LL_ATNTransitions=0}, " +
             "{decision=1, contextSensitivities=0, errors=0, ambiguities=0, lookahead=[2, 2], " +
              "SLL_ATNTransitions=2, DFATransitions=2, LL_Fallback=0, LL_ATNTransitions=0}]";
        assertEquals(expecting, Arrays.toString(info));
        ProfilingATNSimulator.dump(info);
    }

    @Test public void testContextSensitivity() throws Exception {
        Grammar g = new Grammar(
            "parser grammar T;\n"+
            "a : e ID ;\n" +
            "b : e INT ID ;\n" +
            "e : INT | ;\n",
            lg);
        DecisionInfo[] info = interpAndGetDecisionInfo(lg, g, "a", "1 x");
        assertEquals(1, info.length);
        String expecting =
            "[{decision=0, contextSensitivities=1, errors=0, ambiguities=0, lookahead=[3], " +
            "SLL_ATNTransitions=2, DFATransitions=0, LL_Fallback=1, LL_ATNTransitions=1}]";
        assertEquals(expecting, Arrays.toString(info));
        ProfilingATNSimulator.dump(info);
    }

    @Test public void testSimpleLanguage() throws Exception {
        Grammar g = new Grammar(TestXPath.grammar);
        String input =
            "def f(x,y) { x = 3+4*1*1/5*1*1+1*1+1; y; ; }\n" +
            "def g(x,a,b,c,d,e) { return 1+2*x; }\n"+
            "def h(x) { a=3; x=0+1; return a*x; }\n";
        DecisionInfo[] info = interpAndGetDecisionInfo(g.getImplicitLexer(), g, "prog", input);
        ProfilingATNSimulator.dump(info);
        String expecting =
            "[{decision=0, contextSensitivities=1, errors=0, ambiguities=0, lookahead=[3], " +
            "SLL_ATNTransitions=2, DFATransitions=0, LL_Fallback=1, LL_ATNTransitions=1}]";


        assertEquals(expecting, Arrays.toString(info));
        assertEquals(1, info.length);
    }

    @Test public void testDeepLookahead() throws Exception {
        Grammar g = new Grammar(
                "parser grammar T;\n" +
                "s : e ';'\n" +
                "  | e '.' \n" +
                "  ;\n" +
                "e : (ID|INT) ({true}? '+' e)*\n" +       // d=1 entry, d=2 bypass
                "  ;\n",
                lg);

        // pred forces to
        // ambig and ('+' e)* tail recursion forces lookahead to fall out of e
        DecisionInfo[] info = interpAndGetDecisionInfo(lg, g, "s", "a+b+c;");
        // at "+b" it uses k=1 and enters loop then calls e for b...
        // e matches and d=2 uses "+c;" for k=3
        assertEquals(2, info.length);
        String expecting =
            "[{decision=0, contextSensitivities=0, errors=0, ambiguities=0, lookahead=[6], " +
              "SLL_ATNTransitions=6, DFATransitions=0, LL_Fallback=0, LL_ATNTransitions=0}, " +
             "{decision=1, contextSensitivities=0, errors=0, ambiguities=0, lookahead=[1, 3], " +
              "SLL_ATNTransitions=2, DFATransitions=2, LL_Fallback=0, LL_ATNTransitions=0}]";
        assertEquals(expecting, Arrays.toString(info));
        ProfilingATNSimulator.dump(info);
    }

    public DecisionInfo[] interpAndGetDecisionInfo(
            LexerGrammar lg, Grammar g,
            String startRule, String... input)
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
            Rule r = g.rules.get(startRule);
            if ( r==null ) {
                return parser.getDecisionInfo();
            }
            ParserRuleContext t = parser.parse(r.index);
//            try {
//                Utils.waitForClose(t.inspect(parser).get());
//            }
//            catch (Exception e) {
//                e.printStackTrace();
//            }
//
//            System.out.println(t.toStringTree(parser));
        }
        return parser.getDecisionInfo();
   	}
}
