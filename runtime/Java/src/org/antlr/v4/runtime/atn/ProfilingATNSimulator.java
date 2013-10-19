package org.antlr.v4.runtime.atn;

import org.antlr.v4.runtime.Parser;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.dfa.DFAState;
import org.apache.commons.math3.stat.descriptive.rank.Median;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

public class ProfilingATNSimulator extends ParserATNSimulator {
//	public final long[] decisionInvocations;
	public final long[] fullContextFallback;
//	public final long[] nonSLL;
	public final long[] totalTransitions;
	public final long[] ATNTransitions;
	public final long[] fullContextTransitions;
	/** Track every lookahead depth used to make a decision for each decision */
	public final List<Integer>[] lookahead;

	public int numDecisions;

	public int decision;

	public ProfilingATNSimulator(Parser parser) {
		super(parser,
			  parser.getInterpreter().atn,
			  parser.getInterpreter().decisionToDFA,
			  parser.getInterpreter().sharedContextCache);
		numDecisions = atn.decisionToState.size();
//		decisionInvocations = new long[n];
		fullContextFallback = new long[numDecisions];
//		nonSLL = new long[numDecisions];
		totalTransitions = new long[numDecisions];
		ATNTransitions = new long[numDecisions];
		fullContextTransitions = new long[numDecisions];
		lookahead = (List<Integer>[])Array.newInstance(ArrayList.class, numDecisions);
		for (int i=0; i<numDecisions; i++) {
			lookahead[i] = new ArrayList<Integer>();
		}
	}

//	public ProfilingATNSimulator(Parser parser, ATN atn,
//								 DFA[] decisionToDFA,
//								 PredictionContextCache sharedContextCache)
//	{
//		super(parser, parser.getATN(), parser.getATN().decisionToDFA, sharedContextCache);
//		decisionInvocations = new long[atn.decisionToState.size()];
//		fullContextFallback = new long[atn.decisionToState.size()];
//		nonSll = new long[atn.decisionToState.size()];
//		totalTransitions = new long[atn.decisionToState.size()];
//		ATNTransitions = new long[atn.decisionToState.size()];
//		fullContextTransitions = new long[atn.decisionToState.size()];
//		lookahead = (List<Integer>[])Array.newInstance(ArrayList.class, atn.decisionToState.size());
//	}

	@Override
	public int adaptivePredict(TokenStream input, int decision, ParserRuleContext outerContext) {
		try {
			this.decision = decision;
//			decisionInvocations[decision]++;
			int alt = super.adaptivePredict(input, decision, outerContext);
			int k = _stopIndex - _startIndex + 1;
			lookahead[decision].add(k);
			return alt;
		}
		finally {
			this.decision = -1;
		}
	}

	@Override
	protected int execATNWithFullContext(DFA dfa, DFAState D, ATNConfigSet s0, TokenStream input, int startIndex, ParserRuleContext outerContext) {
		fullContextFallback[decision]++;
		return super.execATNWithFullContext(dfa, D, s0, input, startIndex, outerContext);
	}

	@Override
	protected DFAState getExistingTargetState(DFAState previousD, int t) {
		totalTransitions[decision]++;
		return super.getExistingTargetState(previousD, t);
	}

	@Override
	protected DFAState computeTargetState(DFA dfa, DFAState previousD, int t) {
		ATNTransitions[decision]++;
		return super.computeTargetState(dfa, previousD, t);
	}

	@Override
	protected ATNConfigSet computeReachSet(ATNConfigSet closure, int t, boolean fullCtx) {
		if (fullCtx) {
			totalTransitions[decision]++;
			ATNTransitions[decision]++;
			fullContextTransitions[decision]++;
		}

		return super.computeReachSet(closure, t, fullCtx);
	}

	public int getDFASize() {
		int n = 0;
		for (int i = 0; i < decisionToDFA.length; i++) {
			n += decisionToDFA[i].states.size();
		}
		return n;
	}

	public void dump() {
		System.out.println("invocations:");
		for (int i=0; i<numDecisions; i++) {
			List<Integer> ks = lookahead[i];
			Median median = new Median();
			double[] values = new double[ks.size()];
			for (int j=0; j<ks.size(); j++) {
				values[j] = ks.get(j);
			}
			double m = median.evaluate(values);
			if ( ks.size()>0 ) {
				System.out.printf("\t[%d]: %d (median depth=%f)\n", i, ks.size(), m);
			}
			i++;
		}
		System.out.println("depths:");
		int i = 0;
		for (List<Integer> look : lookahead) {
			System.out.printf("\t[%d]: %s\n", i, look);
			i++;
		}
		List<Integer> ll = new ArrayList<Integer>();
		i = 0;
		for (long a : fullContextFallback) {
			if ( a>0 ) ll.add(i);
			i++;
		}
		if ( ll.size()>0 ) {
			System.out.println("Full LL decisions: "+ll);
		}
	}
}
