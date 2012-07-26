package org.antlr.v4.runtime.atn;

import org.antlr.v4.runtime.misc.NotNull;
import org.antlr.v4.runtime.misc.Nullable;

public class ATNConfigWithPred extends ATNConfig {
	@NotNull
	protected final SemanticContext semanticContext;

	public ATNConfigWithPred(@NotNull ATNState state,
					 int alt,
					 @Nullable PredictionContext context)
	{
		this(state, alt, context, SemanticContext.NONE);
	}

	public ATNConfigWithPred(@NotNull ATNState state,
							 int alt,
							 @Nullable PredictionContext context,
							 @NotNull SemanticContext semanticContext)
	{
		super(state, alt, context);
		this.semanticContext = semanticContext;
	}

//	public ATNConfigWithPred(@NotNull ATNConfig c, @NotNull ATNState state) {
//		super(c, state, c.context);
//		if ( c instanceof ATNConfigWithPred ) {
//			this.semanticContext = ((ATNConfigWithPred)c).getSemanticContext();
//		}
//		else {
//			this.semanticContext = null;
//		}
//	}
//
//	public ATNConfigWithPred(@NotNull ATNConfig c, @NotNull ATNState state, @NotNull SemanticContext semanticContext) {
//		this(c, state, c.context, semanticContext);
//	}
//
//	public ATNConfigWithPred(@NotNull ATNConfig c, @NotNull ATNState state, @Nullable PredictionContext context) {
//		super(c, state, context);
//		if ( c instanceof ATNConfigWithPred ) {
//			this.semanticContext = ((ATNConfigWithPred)c).getSemanticContext();
//		}
//		else {
//			this.semanticContext = null;
//		}
//	}
//
//	public ATNConfigWithPred(@NotNull ATNConfig c, @NotNull ATNState state, @Nullable PredictionContext context,
//							 @NotNull SemanticContext semanticContext)
//	{
//		super(state, c.alt, context);
//		this.semanticContext = semanticContext;
//		this.reachesIntoOuterContext = c.reachesIntoOuterContext;
//		this.lexerActionIndex = c.lexerActionIndex;
//	}

	public SemanticContext getSemanticContext() {
		return semanticContext;
	}
}
