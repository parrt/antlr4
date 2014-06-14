package org.antlr.v4.test;

import org.antlr.v4.analysis.AnalysisPipeline;
import org.antlr.v4.codegen.CodeGenerator;
import org.antlr.v4.codegen.JavaTarget;
import org.antlr.v4.runtime.atn.DecisionState;
import org.antlr.v4.runtime.atn.LL1Analyzer;
import org.antlr.v4.runtime.misc.IntervalSet;
import org.antlr.v4.tool.Grammar;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.assertTrue;

public class TestOptionK extends BaseTest {
	@Test
	public void testIDList() throws Exception {
		Grammar g = new Grammar(
			"grammar T;\n" +
			"s : a ;\n" +
			"a  : ID (options {k=1;} : ',' ID)* ;\n" +
			"b : a ',' ;\n" +
			"COMMA : ',';\n" +
			"ID : [a-z]+ ;\n" +
			"INT : [0-9]+ ;\n" +
			"WS : [ \\r\\t\\n]+ -> skip ;\n"
		);
		List<List<String>> results = getAltLookaheadAsStringLists(g, 0);
		boolean disjoint = AnalysisPipeline.disjoint(g.decisionLOOK.get(0));
		System.out.println(results);
		assertTrue(disjoint);
	}

	public List<List<String>> getAltLookaheadAsStringLists(Grammar g, int decision) {
		DecisionState decisionState = g.atn.decisionToState.get(decision);
		IntervalSet[] look;
		if ( decisionState.nonGreedy ) { // nongreedy decisions can't be LL(1)
			look = new IntervalSet[decisionState.getNumberOfTransitions()+1];
		}
		else {
			LL1Analyzer anal = new LL1Analyzer(g.atn);
			look = anal.getDecisionLookahead(decisionState);
		}

		List<List<String>> altLook = new ArrayList<List<String>>();
		for (IntervalSet s : look) {
			CodeGenerator gen = new CodeGenerator(g);
			String[] tokenTypesAsTargetLabels = new JavaTarget(gen).getTokenTypesAsTargetLabels(g, s.toArray());
			altLook.add(Arrays.asList(tokenTypesAsTargetLabels));
		}
		return altLook;
	}

}
