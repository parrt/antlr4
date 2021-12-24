/*
 * Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
 * Use of this file is governed by the BSD 3-clause license that
 * can be found in the LICENSE.txt file in the project root.
 */

package org.antlr.v4.test.runtime;

import org.antlr.v4.runtime.misc.Pair;

import java.util.List;

/** This interface describes everything that a runtime test
 *  descriptor can specify. Most testing descriptors will
 *  subclass {@link UniversalRuntimeTestDescriptor} rather than
 *  implement this directly.  The {@link BaseRuntimeTest}
 *  class pulls data from descriptors to execute tests.
 *
 *  @since 4.6
 */
public interface RuntimeTestDescriptor {
	String getTestName();

	/** A type in {"Lexer", "Parser", "CompositeLexer", "CompositeParser"} */
	String getTestType();

	/** Parser input. Return "" if not input should be provided to the parser or lexer. */
	String getInput();

	/** Output from executing the parser. Return null if no output is expected. */
	String getOutput();

	/** Parse errors Return null if no errors are expected. */
	String getErrors();

	/** Errors generated by ANTLR processing the grammar. Return null if no errors are expected. */
	String getANTLRToolErrors();

	/** The rule at which parsing should start */
	String getStartRule();

	/** For lexical tests, dump the DFA of the default lexer mode to stdout */
	boolean showDFA();

	/** For parsing, engage the DiagnosticErrorListener, dumping results to stderr */
	boolean showDiagnosticErrors();

	/** Most grammars are not using template actions like <writeln()> but I don't want to go change all
	 *  of them.  Hence the "Not" in name.  By default grammars are ST templates unless you use:
	 *
	 *     [flags]
	 *     grammarIsNotTemplate
	 *
	 *  in descriptor file.
	 *
	 */
	boolean grammarIsNotTemplate();

	/** Associates name of grammar like M in M.g4 to string (template) of grammar */
	Pair<String,String> getGrammar();

	/** Return a list of grammars imported into the grammar specified in {#getGrammar}. */
	List<Pair<String,String>> getSlaveGrammars();

	/** Return a string representing the name of the target currently testing
	 *  this descriptor. Multiple instances of the same descriptor class
	 *  can be created to test different targets.
	 */
	String getTarget();

	/** Set the target we are testing */
	void setTarget(String targetName);

	/** Return true if this test should be ignored for the indicated target */
	boolean ignore(String targetName);
}
