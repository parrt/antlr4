package org.antlr.v4.test;

import org.antlr.v4.analysis.AnalysisPipeline;
import org.antlr.v4.codegen.CodeGenerator;
import org.antlr.v4.runtime.misc.IntervalSet;
import org.antlr.v4.tool.Grammar;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class TestOptionK extends BaseTest {
	@Test public void testSingleAltIDList() throws Exception {
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
		int blkDecision = 0;
		assertEquals("1", g.decisionToOptions.get(blkDecision).getOptionString("k"));
		assertFalse(AnalysisPipeline.disjoint(g.decisionLOOK.get(blkDecision)));

		// force LL(1) conflict resolution for decisions with k=1 option
		CodeGenerator gen = new CodeGenerator(g);
		gen.generateParser();
		List<String> results = getAltLookaheadAsStrings(g, blkDecision);
		System.out.println(results);
		assertTrue(AnalysisPipeline.disjoint(g.decisionLOOK.get(blkDecision))); // resolved now

		IntervalSet[] altLook = g.decisionLOOK.get(blkDecision);
		assertEquals("','", altLook[0].toString(g.getTokenDisplayNames()));
		assertEquals("<EOF>", altLook[1].toString(g.getTokenDisplayNames()));
	}

	@Test public void test2AltIDList() throws Exception {
		Grammar g = new Grammar(
			"grammar T;\n" +
			"s : a ;\n" +
			"a  : ID (options {k=1;} : ',' ID | '.' ID)* ;\n" + // inner is LL(1), force entry loop decision to be also
			"b : a ',' ;\n" +
			"COMMA : ',';\n" +
			"ID : [a-z]+ ;\n" +
			"INT : [0-9]+ ;\n" +
			"WS : [ \\r\\t\\n]+ -> skip ;\n"
		);
		int blkDecision = 0;
		int loopEntryDecision = 1;
		assertEquals("1", g.decisionToOptions.get(blkDecision).getOptionString("k"));
		assertEquals("1", g.decisionToOptions.get(loopEntryDecision).getOptionString("k"));
		assertTrue(AnalysisPipeline.disjoint(g.decisionLOOK.get(blkDecision)));
		assertFalse(AnalysisPipeline.disjoint(g.decisionLOOK.get(loopEntryDecision)));

		// force LL(1) conflict resolution for decisions with k=1 option
		CodeGenerator gen = new CodeGenerator(g);
		gen.generateParser();
		List<String> results = getAltLookaheadAsStrings(g, loopEntryDecision);
		System.out.println(results);
		assertTrue(AnalysisPipeline.disjoint(g.decisionLOOK.get(loopEntryDecision))); // resolved now

		IntervalSet[] altLook = g.decisionLOOK.get(loopEntryDecision);
		assertEquals("{'.', ','}", altLook[0].toString(g.getTokenDisplayNames()));
		assertEquals("<EOF>", altLook[1].toString(g.getTokenDisplayNames()));
	}

	@Test public void test2AltIDListWithNonLL1InnerDecision() throws Exception {
		Grammar g = new Grammar(
			"grammar T;\n" +
			"s : a ;\n" +
			"a  : ID (options {k=1;} : ',' ID | ',')* ;\n" + // force both entry loop and block decision to be LL(1)
			"b : a ',' ;\n" +
			"COMMA : ',';\n" +
			"ID : [a-z]+ ;\n" +
			"INT : [0-9]+ ;\n" +
			"WS : [ \\r\\t\\n]+ -> skip ;\n"
		);
		int blkDecision = 0;
		int loopEntryDecision = 1;
		assertEquals("1", g.decisionToOptions.get(blkDecision).getOptionString("k"));
		assertEquals("1", g.decisionToOptions.get(loopEntryDecision).getOptionString("k"));
		assertFalse(AnalysisPipeline.disjoint(g.decisionLOOK.get(blkDecision)));
		assertFalse(AnalysisPipeline.disjoint(g.decisionLOOK.get(loopEntryDecision)));

		// force LL(1) conflict resolution for decisions with k=1 option
		CodeGenerator gen = new CodeGenerator(g);
		gen.generateParser();
		List<String> results = getAltLookaheadAsStrings(g, loopEntryDecision);
		System.out.println(results);
		assertTrue(AnalysisPipeline.disjoint(g.decisionLOOK.get(loopEntryDecision))); // resolved now

		IntervalSet[] altLook = g.decisionLOOK.get(blkDecision);
		assertEquals("','", altLook[0].toString(g.getTokenDisplayNames()));
		assertEquals("{}", altLook[1].toString(g.getTokenDisplayNames()));

		altLook = g.decisionLOOK.get(loopEntryDecision);
		assertEquals("','", altLook[0].toString(g.getTokenDisplayNames()));
		assertEquals("<EOF>", altLook[1].toString(g.getTokenDisplayNames()));
	}
	@Test public void test2AltIDPlusList() throws Exception {
		Grammar g = new Grammar(
			"grammar T;\n" +
			"s : a ;\n" +
			"a  : ID (options {k=1;} : ',' ID | '.' ID)+ ;\n" + // inner is LL(1), force entry loop decision to be also
			"b : a ',' ;\n" +
			"COMMA : ',';\n" +
			"ID : [a-z]+ ;\n" +
			"INT : [0-9]+ ;\n" +
			"WS : [ \\r\\t\\n]+ -> skip ;\n"
		);
		int blkDecision = 0;
		int loopEntryDecision = 1;
		assertEquals("1", g.decisionToOptions.get(blkDecision).getOptionString("k"));
		assertEquals("1", g.decisionToOptions.get(loopEntryDecision).getOptionString("k"));
		assertTrue(AnalysisPipeline.disjoint(g.decisionLOOK.get(blkDecision)));
		assertFalse(AnalysisPipeline.disjoint(g.decisionLOOK.get(loopEntryDecision)));

		// force LL(1) conflict resolution for decisions with k=1 option
		CodeGenerator gen = new CodeGenerator(g);
		gen.generateParser();
		List<String> results = getAltLookaheadAsStrings(g, loopEntryDecision);
		System.out.println(results);
		assertTrue(AnalysisPipeline.disjoint(g.decisionLOOK.get(loopEntryDecision))); // resolved now

		IntervalSet[] altLook = g.decisionLOOK.get(loopEntryDecision);
		assertEquals("{'.', ','}", altLook[0].toString(g.getTokenDisplayNames()));
		assertEquals("<EOF>", altLook[1].toString(g.getTokenDisplayNames()));
	}

	@Test public void test2AltIDPlusListWithNonLL1InnerDecision() throws Exception {
		Grammar g = new Grammar(
			"grammar T;\n" +
			"s : a ;\n" +
			"a  : ID (options {k=1;} : ',' ID | ',')+ ;\n" + // force both entry loop and block decision to be LL(1)
			"b : a ',' ;\n" +
			"COMMA : ',';\n" +
			"ID : [a-z]+ ;\n" +
			"INT : [0-9]+ ;\n" +
			"WS : [ \\r\\t\\n]+ -> skip ;\n"
		);
		int blkDecision = 0;
		int loopEntryDecision = 1;
		assertEquals("1", g.decisionToOptions.get(blkDecision).getOptionString("k"));
		assertEquals("1", g.decisionToOptions.get(loopEntryDecision).getOptionString("k"));
		assertFalse(AnalysisPipeline.disjoint(g.decisionLOOK.get(blkDecision)));
		assertFalse(AnalysisPipeline.disjoint(g.decisionLOOK.get(loopEntryDecision)));

		// force LL(1) conflict resolution for decisions with k=1 option
		CodeGenerator gen = new CodeGenerator(g);
		gen.generateParser();
		List<String> results = getAltLookaheadAsStrings(g, loopEntryDecision);
		System.out.println(results);
		assertTrue(AnalysisPipeline.disjoint(g.decisionLOOK.get(loopEntryDecision))); // resolved now

		IntervalSet[] altLook = g.decisionLOOK.get(blkDecision);
		assertEquals("','", altLook[0].toString(g.getTokenDisplayNames()));
		assertEquals("{}", altLook[1].toString(g.getTokenDisplayNames()));

		altLook = g.decisionLOOK.get(loopEntryDecision);
		assertEquals("','", altLook[0].toString(g.getTokenDisplayNames()));
		assertEquals("<EOF>", altLook[1].toString(g.getTokenDisplayNames()));
	}

	@Test public void testSingleAltOption() throws Exception {
		Grammar g = new Grammar(
			"grammar T;\n" +
			"s : a ;\n" +
			"a  : ID (options {k=1;} : '.' '*')? ;\n" +
			"b : a '.' ;\n" +
			"COMMA : ',';\n" +
			"DOT : '.';\n" +
			"ID : [a-z]+ ;\n" +
			"INT : [0-9]+ ;\n" +
			"WS : [ \\r\\t\\n]+ -> skip ;\n"
		);
		assertEquals("1", g.decisionToOptions.get(0).getOptionString("k"));
		assertFalse(AnalysisPipeline.disjoint(g.decisionLOOK.get(0)));

		// force LL(1) conflict resolution for decisions with k=1 option
		CodeGenerator gen = new CodeGenerator(g);
		gen.generateParser();
		List<String> results = getAltLookaheadAsStrings(g, 0);
		System.out.println(results);
		assertTrue(AnalysisPipeline.disjoint(g.decisionLOOK.get(0))); // resolved now

		IntervalSet[] altLook = g.decisionLOOK.get(0);
		assertEquals("'.'", altLook[0].toString(g.getTokenDisplayNames()));
		assertEquals("<EOF>", altLook[1].toString(g.getTokenDisplayNames()));
	}

	@Test public void test2AltOption() throws Exception {
		Grammar g = new Grammar(
			"grammar T;\n" +
			"s : a ;\n" +
			"a  : ID (options {k=1;} : '.' '*' | ',' ID)? ;\n" + // force LL(1) even though alts 1,3 non-LL(1)
			"b : a '.' ;\n" +
			"COMMA : ',';\n" +
			"DOT : '.';\n" +
			"ID : [a-z]+ ;\n" +
			"INT : [0-9]+ ;\n" +
			"WS : [ \\r\\t\\n]+ -> skip ;\n"
		);
		assertEquals("1", g.decisionToOptions.get(0).getOptionString("k"));
		assertFalse(AnalysisPipeline.disjoint(g.decisionLOOK.get(0)));

		// force LL(1) conflict resolution for decisions with k=1 option
		CodeGenerator gen = new CodeGenerator(g);
		gen.generateParser();
		assertTrue(AnalysisPipeline.disjoint(g.decisionLOOK.get(0))); // resolved now

		IntervalSet[] altLook = g.decisionLOOK.get(0);
		assertEquals("'.'", altLook[0].toString(g.getTokenDisplayNames()));
		assertEquals("','", altLook[1].toString(g.getTokenDisplayNames()));
		assertEquals("<EOF>", altLook[2].toString(g.getTokenDisplayNames()));
	}

	public List<String> getAltLookaheadAsStrings(Grammar g, int decision) {
		List<String> altLook = new ArrayList<String>();
		for (IntervalSet s : g.decisionLOOK.get(decision)) {
			altLook.add( s.toString(g.getTokenDisplayNames()) );
		}
		return altLook;
	}
}
