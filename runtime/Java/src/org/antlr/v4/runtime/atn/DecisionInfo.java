package org.antlr.v4.runtime.atn;

import java.util.ArrayList;
import java.util.List;

public class DecisionInfo {
    /** ALL(*) paper says: 717.6s to parse Java 1.6 corpus without dfa (no trees).
     *  Takes 3.73s to reparse (pure DFA, no trees). That ratio 717.6 / 3.73 = 192.3861 means
     *  ATN transitions are about 192 times more expensive
     */
    public static final double ATN_TO_DFA_TRANSITION_COST = 717.6 / 3.73;

    public int decision;                // which decision number 0..n-1
    public long invocations;

    public List<ContextSensitivityInfo> contextSensitivities = new ArrayList<ContextSensitivityInfo>();
    public List<ErrorInfo>              errors = new ArrayList<ErrorInfo>();
    public List<AmbiguityInfo>          ambiguities = new ArrayList<AmbiguityInfo>();

    public long totalLook;
    public long minLook;
    public long maxLook;

    // TODO: PREDICATE EVALS!!!!!!!!!!!!!!!!!

    public long SLL_ATNTransitions;     // ATN (not DFA) transitions
    public long DFATransitions;         // DFA (not ATN) transitions

    public long LL_Fallback;            // how many times SLL failed and we tried LL; always 0 if SLL mode
    public long LL_ATNTransitions;      // ATN (not DFA) transitions
//    public long LL_Transitions;         // LL ATN transitions; always 0 if SLL mode

        //       	public long nonSLL;
//    public long transitions; // TODO: isn't this just sum of lookahead elements?

    public DecisionInfo(int decision) {
        this.decision = decision;
    }

    public double cost() {
        return (SLL_ATNTransitions+LL_ATNTransitions) * ATN_TO_DFA_TRANSITION_COST + DFATransitions;
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
