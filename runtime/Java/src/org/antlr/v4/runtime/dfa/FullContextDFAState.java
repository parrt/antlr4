package org.antlr.v4.runtime.dfa;

import org.antlr.v4.runtime.atn.PredictionContext;
import org.antlr.v4.runtime.atn.SemanticContext;
import org.antlr.v4.runtime.misc.DoubleKeyMap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 A DFA state that acts like a trampoline to bounce us to a full context
 retry of the ATN.

 Rather than always retrying the ATN simulation with full context,
 we use a cache to detect full context parsing conditions that we
 have seen before. If we reach one of these states, then the input
 resulted in a conflict among the DFA states. Once we do a retry,
 we will get a predicted alternative (or an error). We can save
 the context -> prediction in a map. The next time, we can test
 the context to see if we've been at this state with this exact
 context before. This cut the parsing time in half, but I forgot
 to consider predicates.

 The only wrinkle to this strategy are the predicates. When we
 compute the start state for a full context retry, it collects
 predicates and we test them to see which configurations we can
 turn off. This results in a much faster ATN simulation and also
 removes a landmine in left recursive expression rules that can
 occur due to configuration set explosion. A FullContextDFAState
 records the list of predicates found during start state
 computation and records the evaluation results for each context.
 The full context is then tuple: (stack ctx, sem ctx), which
 we can map to a predicated alternative.

 Once we get the predicted alternative, we update the cache by mapping:

   full context -> ([results list] -> predicted alternative)

 using a DoubleKeyMap.

 To test the cache, we look up the current context to see if there
 is a cached result. If so, we retest all the predicates and
 check to see if we have an identical previous boolean result vector.
 If there is a match, we abort the full context retry and return the
 previously predicted alternative.

 When there are no predicates discovered during start state
 computation, we need a special condition in the cache.  A result
 vector of NOPREDS, indicates we can directly predict the specified
 alternative, without testing any predicates.
 */
public class FullContextDFAState extends DFAState {
	public static final boolean[] NOPREDS = new boolean[0];

	/** Map a context to a list of predicates that are visible from ATN
	 *  start state.  Because full context alters what closure can see
	 *  as it exits a rule stop state, the set of visible predicates could
	 *  be different for each context.
	 */
	protected Map<PredictionContext, List<SemanticContext>> contextToVisiblePredicates =
		new HashMap<PredictionContext, List<SemanticContext>>();

	/** Map a (context, predicate result vector) pair to a predicted alternative. */
	protected DoubleKeyMap<PredictionContext, boolean[], Integer> contextToPredicateResults =
		new DoubleKeyMap<PredictionContext, boolean[], Integer>();

	/** Convert a regular DFA state into a FullContextDFAState */
	public FullContextDFAState(DFAState D) {
		this.stateNumber = D.stateNumber;
		this.configs = D.configs;
		this.edges = D.edges;
		this.isAcceptState = false;
	}

	public synchronized void cache(PredictionContext context,
								   LinkedHashMap<SemanticContext,Boolean> predEvals,
								   int prediction)
	{
		boolean[] results = NOPREDS;
		if ( predEvals!=null ) {
			List<SemanticContext> list = new ArrayList<SemanticContext>();
			list.addAll(predEvals.keySet());
			contextToVisiblePredicates.put(context, list);
			results = new boolean[list.size()];
			int i = 0;
			for (Boolean b : predEvals.values()) {
				results[i++] = b;
			}
		}
		contextToPredicateResults.put(context, results, prediction);
	}

	public synchronized Integer getPredictedAlt(PredictionContext context,
												boolean[] predEvals)
	{
		return contextToPredicateResults.get(context, predEvals);
	}

	public synchronized List<SemanticContext> getPredicatesForContext(PredictionContext context) {
		return contextToVisiblePredicates.get(context);
	}

	public boolean hasPredicates() {
		return contextToVisiblePredicates.size() > 0;
	}

	public boolean hasPredicates(PredictionContext context) {
		return contextToVisiblePredicates.containsKey(context);
	}
}
