package org.antlr.v4.runtime.atn;

import java.util.ArrayList;
import java.util.List;

public class DecisionInfo {
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

    public int decision;                // which decision number 0..n-1
    public long invocations;

    public List<ContextSensitivityInfo> contextSensitivities = new ArrayList<ContextSensitivityInfo>();
    public List<ErrorInfo>              errors = new ArrayList<ErrorInfo>();
    public List<AmbiguityInfo>          ambiguities = new ArrayList<AmbiguityInfo>();

    // these depths are max of SLL and LL fallback lookahead depth (normally same but SLL could look deeper)
    public long totalLook;              // sum of all lookahead depths for all decision events
    public long minLook;                // min for any single event
    public long maxLook;

    public List<PredicateContextEvalInfo>      predicateEvals = new ArrayList<PredicateContextEvalInfo>();

    public long SLL_ATNTransitions;     // ATN (not DFA) transitions
    public long DFATransitions;         // DFA (not ATN) transitions

    public long LL_Fallback;            // how many times SLL failed and we tried LL; always 0 if SLL mode
    public long LL_ATNTransitions;      // ATN (not DFA) transitions

    public DecisionInfo(int decision) {
        this.decision = decision;
    }

//    public double cost() {
//        return (SLL_ATNTransitions+LL_ATNTransitions) * ATN_TO_DFA_TRANSITION_COST + DFATransitions;
//    }
//
    public static String getCSV(DecisionInfo[] decisions) {
        StringBuilder buf = new StringBuilder();
        buf.append(
            String.format("\t %3s, %8s, %8s, %8s, %8s, %8s, %8s, %8s, %8s, %8s\n",
                    "dec", "invoc", "fullctx", "total", "min", "max", "DFA", "SLL-ATN", "LL-ATN", "preds")
        );
        for (int i=0; i<decisions.length; i++) {
            DecisionInfo d = decisions[i];
            buf.append(
                    String.format("\t%3d, %8d, %8d, %8d, %8d, %8d, %8d, %8d, %8d, %8d\n",
                            i, d.invocations, d.LL_Fallback,
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

    public static List<Integer> getLLDecisions(DecisionInfo[] decisions) {
        List<Integer> LL = new ArrayList<Integer>();
        for (int i=0; i<decisions.length; i++) {
            long fallBack = decisions[i].LL_Fallback;
            if ( fallBack>0 ) LL.add(i);
        }
        return LL;
    }

    @Override
    public String toString() {
        return "{" +
               "decision=" + decision +
               ", contextSensitivities=" + contextSensitivities.size() +
               ", errors=" + errors.size() +
               ", ambiguities=" + ambiguities.size() +
               ", lookahead=" + totalLook +
               ", SLL_ATNTransitions=" + SLL_ATNTransitions +
               ", DFATransitions=" + DFATransitions +
               ", LL_Fallback=" + LL_Fallback +
               ", LL_ATNTransitions=" + LL_ATNTransitions +
               '}';
    }
}
