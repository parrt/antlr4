/*
 * [The "BSD license"]
 *  Copyright (c) 2012 Terence Parr
 *  Copyright (c) 2012 Sam Harwell
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions
 *  are met:
 *
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  3. The name of the author may not be used to endorse or promote products
 *     derived from this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 *  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 *  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 *  NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.BailErrorStrategy;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.ConsoleErrorListener;
import org.antlr.v4.runtime.DefaultErrorStrategy;
import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.Parser;
import org.antlr.v4.runtime.RecognitionException;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.atn.ATN;
import org.antlr.v4.runtime.atn.ATNConfigSet;
import org.antlr.v4.runtime.atn.ParserATNSimulator;
import org.antlr.v4.runtime.atn.PredictionContextCache;
import org.antlr.v4.runtime.atn.PredictionMode;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.dfa.DFAState;
import org.antlr.v4.runtime.misc.Utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/** Test grammars for ATN v DFA ratio, DFA size, timing
 *
 *  Read in N input files (documents) into memory
 *  Two-stage parse all N files, recording stats for each file.
 *  Dump for processing in R or Python
 */
public class Bootstrap {
	public static enum OptionArgType { NONE, STRING, INT } // NONE implies boolean
	public static class Option {
		String fieldName;
		String name;
		OptionArgType argType;
		String description;

		public Option(String fieldName, String name, String description) {
			this(fieldName, name, OptionArgType.NONE, description);
		}

		public Option(String fieldName, String name, OptionArgType argType, String description) {
			this.fieldName = fieldName;
			this.name = name;
			this.argType = argType;
			this.description = description;
		}
	}
	public static Option[] optionDefs = {
		new Option("TRIALS", "-trials", OptionArgType.INT, "how many trials of N samples?"),
		new Option("N",	"-N", OptionArgType.INT, "how many files to sample from docs"),
		new Option("inputFilePattern",	"-files", OptionArgType.STRING, "input files; e.g., '*.java'"),
	};

	static class InputDocument {
		String fileName;
		char[] content;
		int index; // set by getRandomDocuments

		InputDocument(InputDocument d, int index) {
			this.fileName = d.fileName;
			this.content = d.content;
			this.index = index;
		}

		InputDocument(String fileName, char[] content) {
			this.content = content;
			this.fileName = fileName;
		}

		@Override
		public String toString() {
			return fileName+"["+content.length+"]"+"@"+index;
		}
	}

	/** Simplified from Sam's. This treats all decisions together */
	static class StatisticsParserATNSimulator extends ParserATNSimulator {
		public long totalTransitions;
		public long ATNTransitions;
		public long fullContextTransitions;

		public StatisticsParserATNSimulator(ATN atn, DFA[] decisionToDFA, PredictionContextCache sharedContextCache) {
			super(atn, decisionToDFA, sharedContextCache);
		}

		public StatisticsParserATNSimulator(Parser parser, ATN atn, DFA[] decisionToDFA, PredictionContextCache sharedContextCache) {
			super(parser, atn, decisionToDFA, sharedContextCache);
		}

		@Override
		protected DFAState getExistingTargetState(DFAState previousD, int t) {
			totalTransitions++;
			return super.getExistingTargetState(previousD, t);
		}

		@Override
		protected DFAState computeTargetState(DFA dfa, DFAState previousD, int t) {
			ATNTransitions++;
			return super.computeTargetState(dfa, previousD, t);
		}

		@Override
		protected ATNConfigSet computeReachSet(ATNConfigSet closure, int t, boolean fullCtx) {
			if (fullCtx) {
				totalTransitions++;
				ATNTransitions++;
				fullContextTransitions++;
			}

			return super.computeReachSet(closure, t, fullCtx);
		}

		@Override
		public String toString() {
			return ATNTransitions+","+fullContextTransitions+","+totalTransitions;
		}
	}

	static final Random RANDOM = new Random();
	public static final String TRANSITION_FILE = "transitions.txt";

	// options
	public String inputFilePattern;
	public int TRIALS = 10; // how many times to sample from docs
	public int N = 5;       // how many files in a sample

	protected String grammarName;
	protected String startRuleName;
	List<String> inputFiles = new ArrayList<String>();
	Class<? extends Lexer> lexerClass;
	Class<? extends Parser> parserClass;

	List<InputDocument> documents;
	List<List<StatisticsParserATNSimulator>> trials =
		new ArrayList<List<StatisticsParserATNSimulator>>(); // 1 list per trial

	public static void main(String[] args) throws Exception {
		Bootstrap p = new Bootstrap();
		if ( args.length == 0 ) { p.help(); System.exit(0); }
		p.go(args);
	}

	public void go(String[] args) throws Exception {
		handleArgs(args);
		if (inputFiles.size() > 0 ) {
			List<String> allFiles = new ArrayList<String>();
			for (String fileName : inputFiles) {
				List<String> files = getFilenames(new File(fileName));
				allFiles.addAll(files);
			}
			documents = load(allFiles);
			loadLexerParser();

			// A trial picks N random files from documents
			for (int trial=1; trial<=TRIALS; trial++) {
				System.out.println("TRIAL "+trial);
				List<InputDocument> rdocs = getRandomDocuments(documents, N);
				List<StatisticsParserATNSimulator> stats = process(rdocs);
				trials.add(stats);
			}
//			stats(trials);
//			dump();
			dumpTransitionStats();
		}
	}

	public void dumpTransitionStats() throws IOException {
		// print ATN vs DFA stats for all files at same index
		StringBuilder buf = new StringBuilder();
		for (int f = 0; f < N; f++) {
			for (int t = 0; t < TRIALS; t++) {
				buf.append(f);
				List<StatisticsParserATNSimulator> trial = trials.get(t);
				StatisticsParserATNSimulator stat = trial.get(f);
				double ratio = stat.ATNTransitions / (double) stat.totalTransitions;
				buf.append(", ");
				buf.append(ratio);
			}
			buf.append("\n");
		}
		Utils.writeFile(grammarName+"-"+TRANSITION_FILE, buf.toString());
	}

//	public void dump() {
//		System.out.println("trial, file, ATN, LL, transitions");
//		for (int i = 0; i < trials.size(); i++) {
//			List<StatisticsParserATNSimulator> trial = trials.get(i);
//			for (int j = 0; j < trial.size(); j++) {
//				StatisticsParserATNSimulator stat = trial.get(j);
//				System.out.printf("%d, %d, %d, %d, %d\n",
//								  i+1,
//								  j+1,
//								  stat.ATNTransitions,
//								  stat.fullContextTransitions,
//								  stat.totalTransitions);
//			}
//		}
//	}

//	public void stats(List<List<StatisticsParserATNSimulator>> trials) {
//		double[][] filestats = new double[N][TRIALS];
//		for (int i = 0; i < trials.size(); i++) {
//			List<StatisticsParserATNSimulator> stats = trials.get(i);
//			for (int j = 0; j < stats.size(); j++) {
//				StatisticsParserATNSimulator stat = stats.get(j);
//				filestats[j][i] = stat.ATNTransitions / (double) stat.totalTransitions;
//			}
//		}
//		System.out.println(Arrays.toString(filestats));
//	}

	public List<StatisticsParserATNSimulator> process(List<InputDocument> docs) throws Exception {
		List<StatisticsParserATNSimulator> stats =
			new ArrayList<StatisticsParserATNSimulator>(docs.size());
		for (InputDocument doc : docs) {
			System.out.print(doc+"\t\t");
			ANTLRInputStream input =
				new ANTLRInputStream(doc.content, doc.content.length);
			Constructor<? extends Lexer> lexerCtor =
				lexerClass.getConstructor(CharStream.class);
			Lexer lexer = lexerCtor.newInstance(input);
			Constructor<? extends Parser> parserCtor =
				parserClass.getConstructor(TokenStream.class);
			CommonTokenStream tokens = new CommonTokenStream(lexer);
			Parser parser = parserCtor.newInstance(tokens);
			parser.setBuildParseTree(false); // no parse trees
			DFA[] decisionToDFA = parser.getInterpreter().decisionToDFA;
			PredictionContextCache sharedContextCache =
				parser.getInterpreter().getSharedContextCache();
			StatisticsParserATNSimulator stat =
				new StatisticsParserATNSimulator(parser,
												 parser.getATN(),
												 decisionToDFA,
												 sharedContextCache);
			parser.setInterpreter(stat);
			try {
				Method startRule = parserClass.getMethod(startRuleName);
				parser.getInterpreter().setPredictionMode(PredictionMode.SLL);
				parser.setErrorHandler(new BailErrorStrategy());
				try {
					startRule.invoke(parser, (Object[])null);
				}
				catch (RuntimeException ex) {
					if (ex.getClass() == RuntimeException.class &&
						ex.getCause() instanceof RecognitionException)
					{
						// The BailErrorStrategy wraps the RecognitionExceptions in
						// RuntimeExceptions so we have to make sure we're detecting
						// a true RecognitionException not some other kind
						tokens.reset(); // rewind input stream
						// back to standard listeners/handlers
						parser.addErrorListener(ConsoleErrorListener.INSTANCE);
						parser.setErrorHandler(new DefaultErrorStrategy());
						parser.getInterpreter().setPredictionMode(PredictionMode.LL);
					}
				}

				stats.add(stat);
				System.out.println(stat);
			}
			catch (NoSuchMethodException nsme) {
				System.err.println("No method for rule "+startRuleName+" or it has arguments");
			}
		}
		return stats;
	}

	/** From input documents, grab n in random order */
	public List<InputDocument> getRandomDocuments(List<InputDocument> documents, int n) {
		List<InputDocument> contentList = new ArrayList<InputDocument>(n);
		for (int i=1; i<=n; i++) {
			int r = RANDOM.nextInt(documents.size()); // get random index from 0..|inputfiles|-1
			contentList.add(new InputDocument(documents.get(r), r));
		}
		return contentList;
	}

	/** Get all file contents into input array */
	public List<InputDocument> load(List<String> fileNames) throws IOException {
		List<InputDocument> input = new ArrayList<InputDocument>(fileNames.size());
		for (String f : fileNames) {
			input.add(load(f));
		}
		System.out.println(input.size());
		return input;
	}

	public InputDocument load(String fileName) throws IOException {
		File f = new File(fileName);
		int size = (int)f.length();
		FileInputStream fis = new FileInputStream(fileName);
		InputStreamReader isr = new InputStreamReader(fis);
		char[] data = null;
		try {
			data = new char[size];
			isr.read(data);
		}
		finally {
			isr.close();
		}
		return new InputDocument(fileName, data);
	}

	public List<String> getFilenames(File f) throws Exception {
		List<String> files = new ArrayList<String>();
		getFilenames_(f, files);
		return files;
	}

	public void getFilenames_(File f, List<String> files) throws Exception {
		// If this is a directory, walk each file/dir in that directory
		if (f.isDirectory()) {
			String flist[] = f.list();
			for(int i=0; i < flist.length; i++) {
				getFilenames_(new File(f, flist[i]), files);
			}
		}

		// otherwise, if this is a java file, parse it!
		else if ( ((f.getName().length()>5) &&
			f.getName().substring(f.getName().length()-5).equals(".java")) &&
			f.getName().indexOf('-')<0 ) // don't allow preprocessor files like ByteBufferAs-X-Buffer.java
		{
			files.add(f.getAbsolutePath());
		}
	}

	void loadLexerParser() throws Exception {
		System.out.println("exec "+grammarName+"."+startRuleName);
		String lexerName = grammarName+"Lexer";
		ClassLoader cl = Thread.currentThread().getContextClassLoader();
		try {
			lexerClass = cl.loadClass(lexerName).asSubclass(Lexer.class);
		}
		catch (java.lang.ClassNotFoundException cnfe) {
			System.err.println("Can't load "+lexerName+" as lexer or parser");
			return;
		}

		String parserName = grammarName+"Parser";
		parserClass = cl.loadClass(parserName).asSubclass(Parser.class);
		if ( parserClass==null ) {
			System.err.println("Can't load "+parserName);
		}
	}

	public void help() {
		for (Option o : optionDefs) {
			String name = o.name + (o.argType!=OptionArgType.NONE? " ___" : "");
			String s = String.format(" %-19s %s", name, o.description);
			System.out.println(s);
		}
	}

	protected void handleArgs(String[] args) {
		// for each directory/file specified on the command line
		int i=0;
		grammarName = args[i];
		i++;
		startRuleName = args[i];
		i++;
		while ( args!=null && i<args.length ) {
			String arg = args[i];
			i++;
			if ( arg.charAt(0)!='-' ) { // file name
				if ( !inputFiles.contains(arg) ) inputFiles.add(arg);
				continue;
			}
			boolean found = false;
			for (Option o : optionDefs) {
				if ( arg.equals(o.name) ) {
					found = true;
					Object argValue = null;
					if ( o.argType==OptionArgType.STRING ) {
						argValue = args[i];
						i++;
					}
					else if ( o.argType==OptionArgType.INT ) {
						argValue = Integer.valueOf(args[i]);
						i++;
					}
					// use reflection to set field
					Class<? extends Bootstrap> c = this.getClass();
					try {
						Field f = c.getField(o.fieldName);
						if ( argValue==null ) {
							if ( arg.startsWith("-no-") ) f.setBoolean(this, false);
							else f.setBoolean(this, true);
						}
						else f.set(this, argValue);
					}
					catch (Exception e) {
						System.out.println("can't access field "+o.fieldName);
					}
				}
			}
			if ( !found ) {
				System.out.println("invalid arg: " + arg);
			}
		}
	}

}
