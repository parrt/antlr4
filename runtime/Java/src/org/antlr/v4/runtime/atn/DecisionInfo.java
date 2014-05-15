package org.antlr.v4.runtime.atn;

import java.util.ArrayList;
import java.util.List;

public class DecisionInfo {
    public int decision;                // which decision number 0..n-1
    public List<ContextSensitivityInfo> contextSensitivities = new ArrayList<ContextSensitivityInfo>();
    public List<ErrorInfo>              errors = new ArrayList<ErrorInfo>();
    public List<AmbiguityInfo>          ambiguities = new ArrayList<AmbiguityInfo>();

    /** Track every lookahead depth used to make a decision for each decision */
    // TODO: track for LL/SLL?
    public List<Integer>                lookahead = new ArrayList<Integer>();

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
        return SLL_ATNTransitions+LL_ATNTransitions+DFATransitions;
    }

    @Override
    public String toString() {
        return "{" +
               "decision=" + decision +
               ", contextSensitivities=" + contextSensitivities.size() +
               ", errors=" + errors.size() +
               ", ambiguities=" + ambiguities.size() +
               ", lookahead=" + lookahead +
               ", SLL_ATNTransitions=" + SLL_ATNTransitions +
               ", DFATransitions=" + DFATransitions +
               ", LL_Fallback=" + LL_Fallback +
               ", LL_ATNTransitions=" + LL_ATNTransitions +
               '}';
    }
}
