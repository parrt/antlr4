package org.antlr.v4.runtime.atn;

import java.util.ArrayList;
import java.util.List;

public class DecisionInfo {
    public int decision;                // which decision number 0..n-1
    public long invocations;
    public long timeInPrediction;       // ns count of time in adaptivePredict
                                        // can be wildly inaccurate for any particular decision event
                                        // but overall sum is better. Can also run input/parser pair
                                        // multiple times and take median of each decision's total time

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
