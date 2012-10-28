package org.antlr.v4.runtime.atn;

/** Plain ATNState but for lexer, which needs to know if states are
 *  part of nongreedy subrule.
 */
public class LexerATNState extends ATNState {
	public boolean greedy;

	public LexerATNState() { this(true); }

	public LexerATNState(boolean greedy) {
		this.greedy = greedy;
	}
}
