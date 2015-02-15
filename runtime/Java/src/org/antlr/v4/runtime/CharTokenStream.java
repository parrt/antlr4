package org.antlr.v4.runtime;

import org.antlr.v4.runtime.misc.Pair;

import java.util.LinkedHashMap;
import java.util.Map;

/** Convert an ANTLR CharStream into a TokenSource; this class look like a Lexer.
 *  Use it for "scannerless parsing" where the parser context information
 *  is needed to make tokenization decisions. For example, C + SQL
 *  merged together without any kind of lexical sentinel indicating "An
 *  island of embedded SQL is heading your way" etc...
 *
 *  Not all runtime targets support this. @since 4.5.1.
 *
 *  If your parser grammar is called X:
 *
 *  parser grammar X;
    options {tokenVocab=CharVocab;}
 *
 *  ANTLRInputStream chars = new ANTLRInputStream(input);
	CharsAsTokens charTokens = new CharsAsTokens(chars, MarkdownParser.tokenNames);
	CommonTokenStream tokens = new CommonTokenStream(charTokens);
	XParser parser = new XParser(tokens);
	ParserRuleContext t = parser.file();
 */
public class CharTokenStream implements TokenSource {
    CharStream input;
    String[] tokenNames;
    int line=1;
    int charPosInLine;
    Map<Integer, Integer> charToTokenType = new LinkedHashMap<Integer, Integer>();

    public CharTokenStream(CharStream input, String[] tokenNames) {
        this.input = input;
        this.tokenNames = tokenNames;
        int ttype = 0;
        for (String tname : tokenNames) {
            if ( tname!=null && tname.charAt(0)=='\'' ) {
				int charVal = tname.charAt(1);
				if ( charVal=='\\' ) {
					charVal = tname.charAt(2);
				}
				charToTokenType.put(charVal, ttype);
            }
            ttype++;
        }
    }

	@Override
	public TokenFactory<?> getTokenFactory() {
		return CommonTokenFactory.DEFAULT;
	}

	public Token nextToken() {
		Token t;
		consumeUnknown();
		int c = input.LA(1);
		int i = input.index();
		if ( c == CharStream.EOF ) {
			t = getTokenFactory().create(Token.EOF, "<EOF>");
		}
		else {
			Integer ttypeI = charToTokenType.get(c);
			t = getTokenFactory().create(
					new Pair<TokenSource,CharStream>(this,input),
					ttypeI, String.valueOf((char)c), Token.DEFAULT_CHANNEL, i,  i,
					line, charPosInLine);
		}
		consume();
		return t;
	}

	protected void consumeUnknown() {
		int c = input.LA(1);
        Integer ttypeI = charToTokenType.get(c);
        while ( ttypeI==null && c != CharStream.EOF ) {
            System.err.println("no token type for char '"+(char)c+"'");
            c = consume();
            ttypeI = charToTokenType.get(c);
        }
    }

    protected int consume() {
        int c = input.LA(1);
        if ( c==-1 ) {
			return CharStream.EOF;
		}
		input.consume();
		charPosInLine++;
        if ( c == '\n' ) { charPosInLine = 0; line++; }
        return input.LA(1);
    }

    public String getSourceName() {
        return null;
    }

	@Override
	public int getCharPositionInLine() {
		return 0;
	}

	@Override
	public int getLine() {
		return 0;
	}

	@Override
	public CharStream getInputStream() { return input; }

	@Override
	public void setTokenFactory(TokenFactory<?> factory) {
	}
}
