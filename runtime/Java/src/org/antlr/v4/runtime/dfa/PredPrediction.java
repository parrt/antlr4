package org.antlr.v4.runtime.dfa;

import org.antlr.v4.runtime.atn.SemanticContext;

/** Map a predicate to a predicted alternative: ({..}?, alt) pair */
public class PredPrediction {
	public SemanticContext pred; // never null; at least SemanticContext.NONE
	public int alt;
	public PredPrediction(SemanticContext pred, int alt) {
		this.alt = alt;
		this.pred = pred;
	}
	@Override
	public String toString() {
		return "("+pred+", "+alt+ ")";
	}
}
