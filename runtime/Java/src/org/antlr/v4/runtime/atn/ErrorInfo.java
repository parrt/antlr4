package org.antlr.v4.runtime.atn;

import org.antlr.v4.runtime.TokenStream;

public class ErrorInfo extends DecisionEventInfo {
    public ErrorInfo(int decision, ATNConfigSet configs, TokenStream input,
                     int startIndex, int stopIndex, boolean fullCtx)
    {
        super(decision, configs, input, startIndex, stopIndex, fullCtx);
    }
}
