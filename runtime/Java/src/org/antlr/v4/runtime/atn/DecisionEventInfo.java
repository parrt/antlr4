package org.antlr.v4.runtime.atn;

import org.antlr.v4.runtime.TokenStream;

public class DecisionEventInfo {
    public int decision;
    public ATNConfigSet configs;
    public TokenStream input;
    public int startIndex;
    public int stopIndex;
    public boolean fullCtx;

    public DecisionEventInfo(int decision, ATNConfigSet configs, TokenStream input,
                             int startIndex, int stopIndex, boolean fullCtx)
    {
        this.decision = decision;
        this.fullCtx = fullCtx;
        this.stopIndex = stopIndex;
        this.input = input;
        this.startIndex = startIndex;
        this.configs = configs;
    }
}
