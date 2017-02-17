package org.antlr.v4.runtime.tree;

import org.antlr.v4.runtime.BufferedTokenStream;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.Token;

import java.util.ArrayList;
import java.util.List;

/** Track text of hidden channel tokens to left and right of terminal node
 *  according to the rules borrowed from Roslyn on trivia:
 *
	 "In general, a token owns any trivia after it on the same line up to
	  the next token. Any trivia after that line is associated with the
	  following token. The first token in the source file gets all the
	  initial trivia, and the last sequence of trivia in the file is
	  tacked onto the end-of-file token, which otherwise has zero width."

 *  These rules are implemented by in {@link #collectHiddenTokens}. It
 *  deviates from Roslyn rules in that final whitespace is added to
 *  last real token not the EOF token.
 *
 *  An empty input is a special case. If the start rule has a reference to EOF,
 *  then the tree will also have a terminal node for that. If the input
 *  is empty except for whitespace or comments, then the EOF terminal node
 *  has these as hiddenLeft as a special case.
 *
 *  If there is no reference to EOF, then the parse tree is a single internal
 *  node for the start rule. Consequently there would be no place to stick the
 *  whitespace or comments; in effect, those will not get added to the tree.
 *
 *  To use this class, override these methods to create
 *  TerminalNodeWithHidden nodes:
 *  {@link org.antlr.v4.runtime.Parser#createErrorNode(ParserRuleContext, Token)} and
 *  {@link org.antlr.v4.runtime.Parser#createTerminalNode(ParserRuleContext, Token)}.
 *
 * @since 4.6.1
 */
public class TerminalNodeWithHidden extends TerminalNodeImpl {
	/** Hidden tokens left of this node's token.  hiddenLeft[0]
	 *  is the furthest token from this node's token.
	 */
	protected Token[] hiddenLeft;

	/** Hidden tokens right of this node's token.  hiddenRight[0]
	 *  is the first token after this node's token.
	 */
	protected Token[] hiddenRight;

	public TerminalNodeWithHidden(BufferedTokenStream tokens, int channel, Token symbol) {
		super(symbol);
		collectHiddenTokens(tokens, channel, symbol);
	}

	// TODO: how to collect hidden on error nodes (deleted, inserted, during recovery)
	protected void collectHiddenTokens(BufferedTokenStream tokens, int channel, Token symbol) {
		List<Token> left  = tokens.getHiddenTokensToLeft(symbol.getTokenIndex(), channel);
		if ( left!=null ) {
			Token firstHiddenLeft = left.get(0);
			Token prevReal = null;
			if ( firstHiddenLeft.getTokenIndex()>0 ) {
				prevReal = tokens.get(firstHiddenLeft.getTokenIndex()-1);
			}
			if ( prevReal==null ) { // this symbol is first real token (or EOF token) of file
				List<Token> allBefore = tokens.get(0, symbol.getTokenIndex()-1);
				hiddenLeft = allBefore.toArray(new Token[allBefore.size()]);
			}
			else {
				// collect all tokens on next line after prev real
				List<Token> nextTokens = new ArrayList<>();
				for (Token t : left) {
					if ( t.getLine()>prevReal.getLine() ) {
						nextTokens.add(t);
					}
				}
				hiddenLeft = nextTokens.toArray(new Token[nextTokens.size()]);
			}
		}

		List<Token> right = tokens.getHiddenTokensToRight(symbol.getTokenIndex(), channel);
		if ( right!=null ) {
			Token lastHiddenRight = right.get(right.size()-1);
			Token nextReal = null;
			if ( symbol.getType()!=Token.EOF ) {
				nextReal = tokens.get(lastHiddenRight.getTokenIndex()+1);
			}
			// If this is last real token, collect all hidden to right
			StringBuilder buf = new StringBuilder();
			if ( nextReal.getType()==Token.EOF ) {
				List<Token> allAfter = tokens.get(right.get(0).getTokenIndex(), nextReal.getTokenIndex());
				hiddenRight = allAfter.toArray(new Token[allAfter.size()]);
			}
			else {
				// collect all token text on same line to right
				int tokenLine = symbol.getLine();
				List<Token> nextTokens = new ArrayList<>();
				for (Token t : right) {
					if ( t.getLine()==tokenLine ) {
						nextTokens.add(t);
					}
				}
				hiddenRight = nextTokens.toArray(new Token[nextTokens.size()]);
			}
		}
	}

	public Token[] getHiddenLeft() {
		return hiddenLeft;
	}

	public Token[] getHiddenRight() {
		return hiddenRight;
	}

	public void setHiddenLeft(Token[] hiddenLeft) {
		this.hiddenLeft = hiddenLeft;
	}

	public void setHiddenRight(Token[] hiddenRight) {
		this.hiddenRight = hiddenRight;
	}

	@Override
	public String getText() {
		StringBuilder buf = new StringBuilder();
		if ( hiddenLeft!=null ) {
			for (Token t : hiddenLeft) {
				buf.append(t.getText());
			}
		}
		buf.append(super.getText());
		if ( hiddenRight!=null ) {
			for (Token t : hiddenRight) {
				buf.append(t.getText());
			}
		}
		return buf.toString();
	}
}