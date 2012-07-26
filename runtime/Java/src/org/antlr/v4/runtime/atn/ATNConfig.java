/*
 [The "BSD license"]
  Copyright (c) 2011 Terence Parr
  All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions
  are met:

  1. Redistributions of source code must retain the above copyright
     notice, this list of conditions and the following disclaimer.
  2. Redistributions in binary form must reproduce the above copyright
     notice, this list of conditions and the following disclaimer in the
     documentation and/or other materials provided with the distribution.
  3. The name of the author may not be used to endorse or promote products
     derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
  NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package org.antlr.v4.runtime.atn;

import org.antlr.v4.runtime.Recognizer;
import org.antlr.v4.runtime.misc.NotNull;
import org.antlr.v4.runtime.misc.Nullable;

/** A tuple: (ATN state, predicted alt, syntactic, semantic context).
 *  The syntactic context is a graph-structured stack node whose
 *  path(s) to the root is the rule invocation(s)
 *  chain used to arrive at the state.  The semantic context is
 *  the tree of semantic predicates encountered before reaching
 *  an ATN state.
 */
public class ATNConfig {
	/** The ATN state associated with this configuration */
	@NotNull
	public final ATNState state;

	/** What alt (or lexer rule) is predicted by this configuration */
	public final int alt;

	/** The stack of invoking states leading to the rule/states associated
	 *  with this config.  We track only those contexts pushed during
	 *  execution of the ATN simulator.
	 */
	@Nullable
	public PredictionContext context;

	/**
	 * We cannot execute predicates dependent upon local context unless
	 * we know for sure we are in the correct context. Because there is
	 * no way to do this efficiently, we simply cannot evaluate
	 * dependent predicates unless we are in the rule that initially
	 * invokes the ATN simulator.
	 *
	 * closure() tracks the depth of how far we dip into the
	 * outer context: depth > 0.  Note that it may not be totally
	 * accurate depth since I don't ever decrement. TODO: make it a boolean then
	 */
	public int reachesIntoOuterContext;

	/** Capture lexer action we traverse */
	public int lexerActionIndex = -1; // TODO: move to subclass

	public ATNConfig(@NotNull ATNState state,
					 int alt,
					 @Nullable PredictionContext context)
	{
		this.state = state;
		this.alt = alt;
		this.context = context;
	}

	public static ATNConfig create(@NotNull ATNState state,
								   int alt,
								   @Nullable PredictionContext context)
	{
		return new ATNConfig(state, alt, context);
	}

	/** Copy from c, override state */
	public static ATNConfig create(@NotNull ATNConfig c, @NotNull ATNState state) {
		if ( c instanceof ATNConfigWithPred ) {
			return create(state, c.alt, c.context, c.getSemanticContext());
		}
		return create(state, c.alt, c.context);
	}

	/** Copy from c, override state, context */
	public static ATNConfig create(@NotNull ATNConfig c, @NotNull ATNState state,
								   @Nullable PredictionContext context) {
		return create(state, c.alt, context, c.getSemanticContext());
	}

	/** Copy from c, override state, semctx */
	public static ATNConfig create(@NotNull ATNConfig c, @NotNull ATNState state,
								   @Nullable SemanticContext semanticContext) {
		return create(state, c.alt, c.context, semanticContext);
	}

	/** Copy from c, override state, context, semctx */
	public static ATNConfig create(@NotNull ATNConfig c, @NotNull ATNState state,
								   @Nullable PredictionContext context,
								   @NotNull SemanticContext semanticContext)
	{
		return create(state, c.alt, context, semanticContext);
	}

	public static ATNConfig create(@NotNull ATNState state,
								   int alt,
								   @Nullable PredictionContext context,
								   @NotNull SemanticContext semanticContext)
	{
		return new ATNConfigWithPred(state, alt, context, semanticContext);
	}

	/** An ATN configuration is equal to another if both have
     *  the same state, they predict the same alternative, and
     *  syntactic/semantic contexts are the same.
     */
    @Override
    public boolean equals(Object o) {
		if (!(o instanceof ATNConfig)) {
			return false;
		}

		return this.equals((ATNConfig)o);
	}

	public boolean equals(ATNConfig other) {
		if (this == other) {
			return true;
		} else if (other == null) {
			return false;
		}

		return this.state.stateNumber==other.state.stateNumber
			&& this.alt==other.alt
			&& (this.context==other.context || (this.context != null && this.context.equals(other.context)))
			&& this.getSemanticContext().equals(other.getSemanticContext());
	}

	@Override
	public int hashCode() {
		int hashCode = 7;
		hashCode = 5 * hashCode + state.stateNumber;
		hashCode = 5 * hashCode + alt;
		hashCode = 5 * hashCode + (context != null ? context.hashCode() : 0);
		hashCode = 5 * hashCode + (getSemanticContext()!=null ? getSemanticContext().hashCode() : 0);
        return hashCode;
    }

	@Override
	public String toString() {
		return toString(null, true);
	}

	public String toString(@Nullable Recognizer<?, ?> recog, boolean showAlt) {
		StringBuilder buf = new StringBuilder();
//		if ( state.ruleIndex>=0 ) {
//			if ( recog!=null ) buf.append(recog.getRuleNames()[state.ruleIndex]+":");
//			else buf.append(state.ruleIndex+":");
//		}
		buf.append('(');
		buf.append(state);
		if ( showAlt ) {
            buf.append(",");
            buf.append(alt);
        }
        if ( context!=null ) {
            buf.append(",[");
            buf.append(context.toString());
			buf.append("]");
        }
        if ( getSemanticContext() !=null && getSemanticContext() != SemanticContext.NONE ) {
            buf.append(",");
            buf.append(getSemanticContext());
        }
        if ( reachesIntoOuterContext>0 ) {
            buf.append(",up=").append(reachesIntoOuterContext);
        }
		buf.append(')');
		return buf.toString();
    }

	public SemanticContext getSemanticContext() {
		return null;
	}
}
