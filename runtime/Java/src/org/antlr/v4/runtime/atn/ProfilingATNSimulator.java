package org.antlr.v4.runtime.atn;

import org.antlr.v4.runtime.Parser;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.dfa.DFAState;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ProfilingATNSimulator extends ParserATNSimulator {
    public static class DecisionInfo {
        public int decision;                // which decision number 0..n-1
        public long invocations;
       	public long LLFallback;             // how many times SLL failed and we tried LL; always 0 if SLL mode
//       	public long nonSLL;
       	public long transitions; // TODO: isn't this just sum of lookahead elements?
       	public long ATNTransitions;         // ATN (not DFA) transitions
       	public long LLTransitions;          // LL ATN transitions; always 0 if SLL mode
       	/** Track every lookahead depth used to make a decision for each decision */
       	public List<Integer> lookahead = new ArrayList<Integer>();

        public DecisionInfo(int decision) {
            this.decision = decision;
        }

        @Override
        public String toString() {
            return "{" +
                   "invocations=" + invocations +
                   ", LLFallback=" + LLFallback +
//                   ", nonSLL=" + nonSLL +
                   ", transitions=" + transitions +
                   ", ATNTransitions=" + ATNTransitions +
                   ", LLTransitions=" + LLTransitions +
                   ", lookahead=" + lookahead +
                   '}';
        }
    }

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
	protected int execATNWithFullContext(DFA dfa, DFAState D, ATNConfigSet s0, TokenStream input, int startIndex, ParserRuleContext outerContext) {
        decisions[currentDecision].LLFallback++;
		return super.execATNWithFullContext(dfa, D, s0, input, startIndex, outerContext);
	}

	@Override
	protected DFAState getExistingTargetState(DFAState previousD, int t) {
        decisions[currentDecision].transitions++;
		return super.getExistingTargetState(previousD, t);
	}

	@Override
	protected DFAState computeTargetState(DFA dfa, DFAState previousD, int t) {
        decisions[currentDecision].ATNTransitions++;
		return super.computeTargetState(dfa, previousD, t);
	}

	@Override
	protected ATNConfigSet computeReachSet(ATNConfigSet closure, int t, boolean fullCtx) {
		if (fullCtx) {
            decisions[currentDecision].transitions++;
            decisions[currentDecision].ATNTransitions++;
            decisions[currentDecision].LLTransitions++;
		}

		return super.computeReachSet(closure, t, fullCtx);
	}

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
   		    long fallBack = decisions[i].LLFallback;
   			if ( fallBack>0 ) LL.add(i);
   			i++;
   		}
   		if ( LL.size()>0 ) {
   			System.out.println("Full LL decisions: "+LL);
   		}
   	}
}
