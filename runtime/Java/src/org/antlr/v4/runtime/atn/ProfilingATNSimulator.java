package org.antlr.v4.runtime.atn;

import org.antlr.v4.runtime.Parser;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.dfa.DFAState;
import org.antlr.v4.runtime.misc.NotNull;
import org.antlr.v4.runtime.misc.Nullable;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.BitSet;
import java.util.List;

public class ProfilingATNSimulator extends ParserATNSimulator {
    protected final DecisionInfo[] decisions;
    protected int numDecisions;

    protected int currentDecision;

	public ProfilingATNSimulator(Parser parser) {
        super(parser,
                parser.getInterpreter().atn,
                parser.getInterpreter().decisionToDFA,
                parser.getInterpreter().sharedContextCache);
        numDecisions = atn.decisionToState.size();
        decisions = new DecisionInfo[numDecisions];
        for (int i=0; i<numDecisions; i++) {
            decisions[i] = new DecisionInfo(i);
        }
	}

	@Override
	public int adaptivePredict(TokenStream input, int decision, ParserRuleContext outerContext) {
		try {
			this.currentDecision = decision;
			decisions[decision].invocations++;
			int alt = super.adaptivePredict(input, decision, outerContext);
			int k = _stopIndex - _startIndex + 1;
            decisions[decision].lookahead.add(k);
			return alt;
		}
		finally {
			this.currentDecision = -1;
		}
	}

    @Override
    protected DFAState getExistingTargetState(DFAState previousD, int t) {
        DFAState existingTargetState = super.getExistingTargetState(previousD, t);
        if ( existingTargetState!=null ) {
            decisions[currentDecision].DFATransitions++; // count only if we transition over a DFA state
            if ( existingTargetState==ERROR ) {
                decisions[currentDecision].errors.add(
                        new ErrorInfo(currentDecision, previousD.configs, _input, _startIndex, _stopIndex, false)
                );
            }
        }
        return existingTargetState;
	}

	@Override
	protected ATNConfigSet computeReachSet(ATNConfigSet closure, int t, boolean fullCtx) {
        ATNConfigSet reachConfigs = super.computeReachSet(closure, t, fullCtx);
        if (fullCtx) {
            decisions[currentDecision].LL_ATNTransitions++; // count computation even if error
            if ( reachConfigs!=null ) {
            }
            else { // no reach on current lookahead symbol. ERROR.
                // TODO: does not handle delayed errors per getSynValidOrSemInvalidAltThatFinishedDecisionEntryRule()
                decisions[currentDecision].errors.add(
                    new ErrorInfo(currentDecision, closure, _input, _startIndex, _stopIndex, true)
                );
            }
        }
        else {
            decisions[currentDecision].SLL_ATNTransitions++;
            if ( reachConfigs!=null ) {
            }
            else { // no reach on current lookahead symbol. ERROR.
                decisions[currentDecision].errors.add(
                    new ErrorInfo(currentDecision, closure, _input, _startIndex, _stopIndex, false)
                );
            }
        }
        return reachConfigs;
	}

    @Override
    protected void reportContextSensitivity(@NotNull DFA dfa, int prediction, @NotNull ATNConfigSet configs, int startIndex, int stopIndex) {
        decisions[currentDecision].contextSensitivities.add(
            new ContextSensitivityInfo(currentDecision, configs, _input, startIndex, stopIndex, false)
        );
        super.reportContextSensitivity(dfa, prediction, configs, startIndex, stopIndex);
    }

    @Override
    protected void reportAttemptingFullContext(@NotNull DFA dfa, @Nullable BitSet conflictingAlts, @NotNull ATNConfigSet configs, int startIndex, int stopIndex) {
        decisions[currentDecision].LL_Fallback++;
        super.reportAttemptingFullContext(dfa, conflictingAlts, configs, startIndex, stopIndex);
    }

    @Override
    protected void reportAmbiguity(@NotNull DFA dfa, DFAState D, int startIndex, int stopIndex, boolean exact, @Nullable BitSet ambigAlts, @NotNull ATNConfigSet configs) {
        decisions[currentDecision].ambiguities.add(
            new AmbiguityInfo(currentDecision, configs, _input, startIndex, stopIndex, false)
        );
        super.reportAmbiguity(dfa, D, startIndex, stopIndex, exact, ambigAlts, configs);
    }

    // ---------------------------------------------------------------------

    public DecisionInfo[] getDecisionInfo() {
        return decisions;
    }

	public int getDFASize() {
		int n = 0;
		for (int i = 0; i < decisionToDFA.length; i++) {
			n += decisionToDFA[i].states.size();
		}
		return n;
	}

    protected static int[] toIntArray(List<Integer> ks) {
        int[] values = new int[ks.size()];
        for (int j=0; j<ks.size(); j++) {
            values[j] = ks.get(j);
        }
        return values;
    }

    /** warning: sorts data arg */
    public static double median(int[] data) {
        Arrays.sort(data);
        int middle = data.length/2;
        if ( data.length % 2 == 1 ) { // if odd number, grab middle
            return data[middle];
        }
        else {
            return (data[middle-1] + data[middle]) / 2.0; // average of middle pair
        }
    }

    public static void dump(DecisionInfo[] decisions) {
   		System.out.println("invocations:");
   		for (int i=0; i<decisions.length; i++) {
               long count = decisions[i].invocations;
               System.out.printf("\t[%d]: %d\n", i, count);
           }
           System.out.println("depths:");
           for (int i=0; i<decisions.length; i++) {
               List<Integer> look = decisions[i].lookahead;
   			if ( look.size()>0 ) System.out.printf("\t[%d]: %s median=%7.1f\n", i, look.toString(), median(toIntArray(look)));
   			i++;
   		}
   		List<Integer> LL = new ArrayList<Integer>();
           for (int i=0; i<decisions.length; i++) {
   		    long fallBack = decisions[i].LL_Fallback;
   			if ( fallBack>0 ) LL.add(i);
   			i++;
   		}
   		if ( LL.size()>0 ) {
   			System.out.println("Full LL decisions: "+LL);
   		}
   	}
}
