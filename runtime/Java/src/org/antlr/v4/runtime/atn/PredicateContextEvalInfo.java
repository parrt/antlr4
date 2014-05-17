package org.antlr.v4.runtime.atn;

import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.dfa.DFAState;

import java.util.BitSet;

public class PredicateContextEvalInfo extends DecisionEventInfo {
    public DFAState dfaState;
    public boolean[] evalResults;
    public BitSet predictions;

    public PredicateContextEvalInfo(DFAState dfaState, int decision,
                                    TokenStream input, int startIndex, int stopIndex,
                                    boolean[] evalResults,
                                    BitSet predictions)
    {
        super(decision, dfaState.configs, input, startIndex, stopIndex, dfaState.requiresFullContext);
        this.dfaState = dfaState;
        this.evalResults = evalResults;
        this.predictions = predictions;
    }
}
