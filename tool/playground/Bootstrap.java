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
import org.antlr.v4.runtime.atn.LexerATNSimulator;
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
import java.util.Collections;
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
		new Option("showFileNames",	"-showfiles", "show file names as they are parsed")
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

	public static class ParseStats {
		public long totalTransitions;
		public long ATNTransitions;
		public long fullContextTransitions;
		public int startDFASize;
		public int stopDFASize;

		public long timeSLL;
		public long timeLL;
	}

	/** Simplified from Sam's. This treats all decisions together */
	static class StatsParserATNSimulator extends ParserATNSimulator {
		public final ParseStats info;

		public StatsParserATNSimulator(ParseStats info,
									   Parser parser, ATN atn,
									   DFA[] decisionToDFA,
									   PredictionContextCache sharedContextCache)
		{
			super(parser, atn, decisionToDFA, sharedContextCache);
			this.info = info;
			info.startDFASize = getDFASize();
		}

		public void finish() {
			info.stopDFASize = getDFASize();
		}

		@Override
		protected DFAState getExistingTargetState(DFAState previousD, int t) {
			info.totalTransitions = info.totalTransitions + 1;
			return super.getExistingTargetState(previousD, t);
		}

		@Override
		protected DFAState computeTargetState(DFA dfa, DFAState previousD, int t) {
			info.ATNTransitions = info.ATNTransitions + 1;
			return super.computeTargetState(dfa, previousD, t);
		}

		@Override
		protected ATNConfigSet computeReachSet(ATNConfigSet closure, int t, boolean fullCtx) {
			if (fullCtx) {
				info.totalTransitions = info.totalTransitions + 1;
				info.ATNTransitions = info.ATNTransitions + 1;
				info.fullContextTransitions = info.fullContextTransitions + 1;
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

		@Override
		public String toString() {
			return info.ATNTransitions +","+ info.fullContextTransitions +","+ info.totalTransitions;
		}
	}

	static final Random RANDOM = new Random();
	public static final String TRANSITION_FILE = "transitions.txt";
	public static final String DFASIZE_FILE = "dfasizes.txt";
	public static final String TIMING_FILE = "timings.txt";

	// options
	public String inputFilePattern;
	public int TRIALS = 10; // how many times to sample from docs
	public int N = 5;       // how many files in a sample
	public boolean showFileNames = false;

	protected String grammarName;
	protected String startRuleName;
	List<String> inputFiles = new ArrayList<String>();
	Class<? extends Lexer> lexerClass;
	Class<? extends Parser> parserClass;

	List<InputDocument> documents;
	List<List<ParseStats>> trials; // 1 list per trial

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

			System.out.println(TRIALS+" trials, "+N+" files");
			doTrials();

//			stats(trials);
//			dump();
			dump();
		}
	}

	public void doTrials() throws Exception {
		// A trial picks N random files from documents
		trials = new ArrayList<List<ParseStats>>();
		for (int trial=1; trial<=TRIALS; trial++) {
			System.out.println("TRIAL "+trial);
			List<InputDocument> rdocs = getRandomDocuments(documents, N);
			List<ParseStats> stats = processSample(rdocs);
			trials.add(stats);
		}
	}

	public void dump() throws IOException {
		// print ATN vs DFA stats for all files at same index
		StringBuilder transitions = new StringBuilder();
		StringBuilder dfaSizes = new StringBuilder();
		StringBuilder timings = new StringBuilder();

		for (int f = 0; f < N; f++) {
			long cumTime = 0;
			for (int t = 0; t < TRIALS; t++) {
//				transitions.append(f);
//				dfaSizes.append(f);
//				timings.append(f);
				List<ParseStats> trial = trials.get(t);
				ParseStats stat = trial.get(f);
				double atnRatio = stat.ATNTransitions / (double) stat.totalTransitions;
				if ( t>0 ) transitions.append(", ");
				transitions.append(atnRatio); //+"("+stat.ATNTransitions+"/"+stat.totalTransitions+")");
				if ( t>0 ) dfaSizes.append(", ");
				dfaSizes.append(stat.stopDFASize);
				// calc cumulative time after all files thus far for this trial
				cumTime += stat.timeLL;
				if ( t>0 ) timings.append(", ");
				timings.append(cumTime);
			}
			transitions.append("\n");
			dfaSizes.append("\n");
			timings.append("\n");
		}
		Utils.writeFile(grammarName + "-" + TRANSITION_FILE, transitions.toString());
		Utils.writeFile(grammarName + "-" + DFASIZE_FILE, dfaSizes.toString());
		Utils.writeFile(grammarName + "-" + TIMING_FILE, timings.toString());
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

	/** Do a single trial of docs to parse, wipe DFA at start, new parse/lexer
	 *  objects per parse.
	 */
	public List<ParseStats> processSample(List<InputDocument> docs) throws Exception {
		{	// wipe lexer/parser DFA
			Constructor<? extends Lexer> lexerCtor =
				lexerClass.getConstructor(CharStream.class);
			Lexer lexer = lexerCtor.newInstance((CharStream)null);
			ATN atn = lexer.getATN();
			LexerATNSimulator l = lexer.getInterpreter();
			for (int d = 0; d < l.decisionToDFA.length; d++) {
				l.decisionToDFA[d] = new DFA(atn.getDecisionState(d), d);
			}

			Constructor<? extends Parser> parserCtor =
				parserClass.getConstructor(TokenStream.class);
			Parser parser = parserCtor.newInstance((TokenStream)null);
			atn = parser.getATN();
			ParserATNSimulator p = parser.getInterpreter();
			for (int d = 0; d < p.decisionToDFA.length; d++) {
				p.decisionToDFA[d] = new DFA(atn.getDecisionState(d), d);
			}
			System.gc();
		}

		int d = 0;
		List<ParseStats> parseStats = new ArrayList<ParseStats>(docs.size());
		for (InputDocument doc : docs) {
			if ( showFileNames ) System.out.print(doc);
//			if ( d % 10 == 0 ) System.out.print(" "+d);
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
			ParseStats oneFileStats = new ParseStats();
			StatsParserATNSimulator sim =
				new StatsParserATNSimulator(
					oneFileStats,
					parser,
					parser.getATN(),
					decisionToDFA,
					sharedContextCache);
			parser.setInterpreter(sim);
			try {
				Method startRule = parserClass.getMethod(startRuleName);
				parser.getInterpreter().setPredictionMode(PredictionMode.SLL);
				parser.setErrorHandler(new BailErrorStrategy());
				try {
					final long startTime = System.nanoTime();
					startRule.invoke(parser, (Object[])null);
					final long stopTime = System.nanoTime();
					oneFileStats.timeSLL = stopTime - startTime;
				}
				catch (RuntimeException ex) {
					if (ex.getClass() == RuntimeException.class &&
						ex.getCause() instanceof RecognitionException)
					{
						System.err.println("FAIL OVER TO LL");
						// The BailErrorStrategy wraps the RecognitionExceptions in
						// RuntimeExceptions so we have to make sure we're detecting
						// a true RecognitionException not some other kind
						tokens.reset(); // rewind input stream
						// back to standard listeners/handlers
						parser.addErrorListener(ConsoleErrorListener.INSTANCE);
						parser.setErrorHandler(new DefaultErrorStrategy());
						parser.getInterpreter().setPredictionMode(PredictionMode.LL);

						final long startTime = System.nanoTime();
						startRule.invoke(parser, (Object[])null);
						final long stopTime = System.nanoTime();
						oneFileStats.timeLL = stopTime - startTime;
					}
				}

				sim.finish();

				parseStats.add(oneFileStats);
				if ( showFileNames ) System.out.println("\t\t"+sim+", "+((double)oneFileStats.ATNTransitions/oneFileStats.totalTransitions));
			}
			catch (NoSuchMethodException nsme) {
				System.err.println("No method for rule "+startRuleName+" or it has arguments");
			}
//			if ( d % 10 == 0 ) System.out.println();
			d++;
		}
		return parseStats;
	}

	/** From input documents, grab n in random order w/o replacement */
	public List<InputDocument> getRandomDocuments(List<InputDocument> documents, int n) {
		List<InputDocument> documents_ = new ArrayList<InputDocument>(documents);
		Collections.shuffle(documents_, RANDOM);
		List<InputDocument> contentList = new ArrayList<InputDocument>(n);
		for (int i=0; i<n; i++) { // get first n files from shuffle and set file index for it
			contentList.add(new InputDocument(documents_.get(i), i));
		}
		return contentList;
	}

	/** From input documents, grab n in random order w replacement */
	public List<InputDocument> getRandomDocumentsWithRepl(List<InputDocument> documents, int n) {
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
		System.out.println(input.size()+" files");
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
