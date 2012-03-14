/*
 [The "BSD license"]
  Copyright (c) 2012 Terence Parr
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
package org.antlr.v4.runtime.tree;

import org.antlr.v4.runtime.Token;

/** Result is return type of visit methods. Use Result=Void for no return type. */
public abstract class AbstractParseTreeVisitor<Symbol extends Token, Result> implements ParseTreeVisitor<Symbol, Result> {
	@Override
	public Result visit(ParseTree<? extends Symbol> ctx) {
		return ctx.accept(this);
	}

	/** Visit all rule, nonleaf children. Not that useful if you are using T as
	 *  non-Void.  This returns value returned from last child visited,
	 *  losing all computations from first n-1 children.  Works fine for
	 *  ctxs with one child then.
	 *  Handy if you are just walking the tree with a visitor and only
	 *  care about some nodes.  The ParserRuleContext.accept() method
	 *  walks all children by default; i.e., calls this method.
	 */
	@Override
	public Result visitChildren(ParseTree.RuleNode<? extends Symbol> node) {
		Result result = null;
		int n = node.getChildCount();
		for (int i = 0; i < n; i++) {
			ParseTree<? extends Symbol> c = node.getChild(i);
			result = c.accept(this);
		}
		return result;
	}

	@Override
	public Result visitTerminal(ParseTree.TerminalNode<? extends Symbol> node) {
		return null;
	}

	@Override
	public Result visitErrorNode(ParseTree.ErrorNode<? extends Symbol> node) {
		return null;
	}
}
