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
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.DiagnosticErrorListener;
import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.Parser;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.atn.ATN;
import org.antlr.v4.runtime.atn.ATNConfigSet;
import org.antlr.v4.runtime.atn.ParserATNSimulator;
import org.antlr.v4.runtime.atn.PredictionContextCache;
import org.antlr.v4.runtime.atn.PredictionMode;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.dfa.DFAState;

import javax.print.PrintException;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
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
public class Profile {
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
			return fileName+"@"+index;
		}
	}
	static class StatisticsParserATNSimulator extends ParserATNSimulator {
		public long totalTransitions;
		public long computedTransitions;

		public StatisticsParserATNSimulator(ATN atn, DFA[] decisionToDFA, PredictionContextCache sharedContextCache) {
			super(atn, decisionToDFA, sharedContextCache);
		}

		public StatisticsParserATNSimulator(Parser parser, ATN atn, DFA[] decisionToDFA, PredictionContextCache sharedContextCache) {
			super(parser, atn, decisionToDFA, sharedContextCache);
		}

		@Override
		protected DFAState getExistingTargetState(DFAState previousD, int t) {
			// called for both DFA and ATN edge transitions
			totalTransitions++;
			return super.getExistingTargetState(previousD, t);
		}

		@Override
		protected DFAState computeTargetState(DFA dfa, DFAState previousD, int t) {
			computedTransitions++;
			return super.computeTargetState(dfa, previousD, t);
		}

		@Override
		protected ATNConfigSet computeReachSet(ATNConfigSet closure, int t, boolean fullCtx) {
			return super.computeReachSet(closure, t, fullCtx);
		}
	}
	static final Random RANDOM = new Random();

	static protected String grammarName;
	static protected String startRuleName;
	static Class<? extends Lexer> lexerClass;
	static Class<? extends Parser> parserClass;

	static List<InputDocument> documents;

	public static void main(String[] args) throws Exception {
		if (args.length > 0 ) {
			// for each directory/file specified on the command line
			List<String> inputFiles = new ArrayList<String>();
			int i=0;
			grammarName = args[i];
			i++;
			startRuleName = args[i];
			i++;
			while ( i<args.length ) {
				String arg = args[i];
				i++;
				if ( arg.charAt(0)!='-' ) { // input file name
					inputFiles.add(arg);
					continue;
				}
			}
			List<String> javaFiles = new ArrayList<String>();
			for (String fileName : inputFiles) {
				List<String> files = getFilenames(new File(fileName));
				javaFiles.addAll(files);
			}
			documents = load(javaFiles);
			List<InputDocument> rdocs = getRandomDocuments(documents, 5);

			loadLexerParser();
			process(rdocs);
		}
		else {
			System.err.println("Usage: java Main <directory or file name>");
		}
	}

	/** From input documents, grab n in random order */
	public static List<InputDocument> getRandomDocuments(List<InputDocument> documents, int n) {
		List<InputDocument> contentList = new ArrayList<InputDocument>(n);
		for (int i=1; i<=n; i++) {
			int r = RANDOM.nextInt(documents.size()); // get random index from 0..|inputfiles|-1
			contentList.add(new InputDocument(documents.get(r), r));
		}
		return contentList;
	}

	/** Get all file contents into input array */
	public static List<InputDocument> load(List<String> fileNames) throws IOException {
		List<InputDocument> input = new ArrayList<InputDocument>(fileNames.size());
		for (String f : fileNames) {
			input.add(load(f));
		}
		System.out.println(input.size());
		return input;
	}

	public static InputDocument load(String fileName) throws IOException {
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

	public static List<String> getFilenames(File f) throws Exception {
		List<String> files = new ArrayList<String>();
		getFilenames_(f, files);
		return files;
	}

	public static void getFilenames_(File f, List<String> files) throws Exception {
		// If this is a directory, walk each file/dir in that directory
		if (f.isDirectory()) {
			String flist[] = f.list();
			for(int i=0; i < flist.length; i++) {
				getFilenames_(new File(f, flist[i]), files);
			}
		}

		// otherwise, if this is a java file, parse it!
		else if ( ((f.getName().length()>5) &&
			f.getName().substring(f.getName().length()-5).equals(".java")) )
		{
			files.add(f.getAbsolutePath());
		}
	}

	static void loadLexerParser() throws Exception {
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

	public static void process(List<InputDocument> docs) throws Exception {
		for (InputDocument doc : docs) {
			System.out.println(doc);
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
			PredictionContextCache sharedContextCache = parser.getInterpreter().getSharedContextCache();
			parser.setInterpreter(
				new StatisticsParserATNSimulator(parser, parser.getATN(),
												 decisionToDFA,
												 sharedContextCache)
								 );
			try {
				Method startRule = parserClass.getMethod(startRuleName);
				startRule.invoke(parser, (Object[])null);
			}
			catch (NoSuchMethodException nsme) {
				System.err.println("No method for rule "+startRuleName+" or it has arguments");
			}
		}
	}

}
