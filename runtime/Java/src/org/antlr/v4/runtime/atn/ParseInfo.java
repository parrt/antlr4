package org.antlr.v4.runtime.atn;

import org.antlr.v4.runtime.dfa.DFA;

import java.util.ArrayList;
import java.util.List;

public class ParseInfo {
    /** ALL(*) paper says: 717.6s to parse Java 1.6 corpus without dfa (no trees).
     *  Takes 3.73s to reparse (pure DFA, no trees). That ratio 717.6 / 3.73 = 192.3861 means
     *  ATN transitions are about 192 times more expensive.  Max lookahead very shallow.
     *
     *  Hmm... C grammar that has some deep lookahead shows much lower ratio. (albeit with atn profiling on)
     *
     *      C SLL grammar with dfa and SLL 6295ms  (3rd run)
     *      C SLL grammar NO   dfa and SLL 26776ms (3rd run)
     *      ratio = 4.25x
     *
     *      C LL  grammar with dfa 2-stage 10895ms (3rd run)
     *      C LL  grammar NO   dfa 2-stage 32867ms (3rd run)
     *      ratio = 3x
     */
    public static final double ATN_TO_DFA_TRANSITION_COST = 717.6 / 3.73;

    protected ProfilingATNSimulator atnSimulator;

    public ParseInfo(ProfilingATNSimulator atnSimulator) {
        this.atnSimulator = atnSimulator;
    }

    //    public double cost() {
    //        return (SLL_ATNTransitions+LL_ATNTransitions) * ATN_TO_DFA_TRANSITION_COST + DFATransitions;
    //    }
    //

    public String getCSV() {
        DecisionInfo[] decisions = atnSimulator.getDecisionInfo();
        StringBuilder buf = new StringBuilder();
        buf.append(
                String.format("\t %3s, %8s, %8s, %8s, %8s, %8s, %8s, %8s, %8s, %8s, %8s, %8s\n",
                        "dec", "invoc", "time ns", "DFA states", "fullctx", "total", "min", "max", "DFA", "SLL-ATN", "LL-ATN", "preds")
        );
        for (int i=0; i<decisions.length; i++) {
            DecisionInfo d = decisions[i];
            buf.append(
                    String.format("\t%3d, %8d, %8d, %8d, %8d, %8d, %8d, %8d, %8d, %8d, %8d, %8d\n",
                            i,
                            d.invocations,
                            d.timeInPrediction,
                            getDFASize(i),
                            d.LL_Fallback,
                            d.totalLook,
                            d.minLook,
                            d.maxLook,
                            d.DFATransitions,
                            d.SLL_ATNTransitions,
                            d.LL_ATNTransitions,
                            d.predicateEvals.size())
            );
        }
        return buf.toString();
    }

    public DecisionInfo[] getDecisionInfo() {
        return atnSimulator.getDecisionInfo();
    }

    public List<Integer> getLLDecisions() {
        DecisionInfo[] decisions = atnSimulator.getDecisionInfo();
        List<Integer> LL = new ArrayList<Integer>();
        for (int i=0; i<decisions.length; i++) {
            long fallBack = decisions[i].LL_Fallback;
            if ( fallBack>0 ) LL.add(i);
        }
        return LL;
    }

    public long getTotalTimeInPrediction() {
        DecisionInfo[] decisions = atnSimulator.getDecisionInfo();
        long t = 0;
        for (int i=0; i<decisions.length; i++) {
            t += decisions[i].timeInPrediction;
        }
        return t;
    }

    public int getDFASize() {
        int n = 0;
        DFA[] decisionToDFA = atnSimulator.decisionToDFA;
        for (int i = 0; i < decisionToDFA.length; i++) {
            n += getDFASize(i);
        }
        return n;
    }

    public int getDFASize(int decision) {
        DFA decisionToDFA = atnSimulator.decisionToDFA[decision];
        return decisionToDFA.states.size();
    }
}
