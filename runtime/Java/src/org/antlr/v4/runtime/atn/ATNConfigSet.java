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

import org.antlr.v4.runtime.misc.IntervalSet;
import org.antlr.v4.runtime.misc.OrderedHashSet;

import java.util.HashSet;
import java.util.Set;

/** Specialized OrderedHashSet that can track info about the set.
 *  Might be able to optimize later w/o affecting code that uses this set.
 *  Track configs by alt so we can compress those context trees.
 *
 *  Sam's sharing: 2 configs that have same state, same alt, same sem ctx:
 *  that's one atn config.  ATNConfig is node in graph. context graph ptr is
 *  what you share.
 *
 *  equals: must remember comparing two nodes, save true/false to avoid
 *  recomputing lest even graph is same cost to compare as tree. graph
 *  enum of paths is same cost of tree.
 *
 *  in full ctx, cannot trim suffixes but we still share.
 *  merge case that looks like suffix:
 *    start at s with [] then can get [10] [10 4]. graph looks like
 *    10->4, 10 also points to EMPTY.
 *
 *  example.
 *  a b d
 *  a b c
 *  what if a's are different nodes? must join
 *  what if we want to add e c d?
 *
 *  might be merging two graphs. crap:
 *  a b d
 e b d
 a c d
 e c d

 another case:
 a b d
 e b d
 a b d d
 e b d d

 think about a map that is adjacency list

 ours is more complciated due to local ctx. tomita is always doing full ctx
 so no worries about suffix.

 merge on graph is the key so that we can call rule and have graph as parent:
 c calls b calls a, etc...

 a->b->c
  |->b->d
  |->b->e

 now with this config, we call another, it just points at a.
 */
public class ATNConfigSet extends OrderedHashSet<ATNConfig> {
	// TODO: these fields make me pretty uncomfortable but nice to pack up info together, saves recomputation
	// TODO: can we track conflicts as they are added to save scanning configs later?
	public int uniqueAlt;
	public IntervalSet conflictingAlts;
	public boolean hasSemanticContext;
	public boolean dipsIntoOuterContext;

	public ATNConfigSet() { }

	@Override
	public Object clone() {
		return new ATNConfigSet(this);
	}

	public ATNConfigSet(ATNConfigSet old) {
		addAll(old);
		this.uniqueAlt = old.uniqueAlt;
		this.conflictingAlts = old.conflictingAlts;
		this.hasSemanticContext = old.hasSemanticContext;
		this.dipsIntoOuterContext = old.dipsIntoOuterContext;
	}

	/** Share common subtrees.
	 *
	 * when i add suffix, just don't add it.
	 *
	 */
	@Override
	public boolean add(ATNConfig value) {
		return super.add(value);
	}

	public Set<ATNState> getStates() {
		Set<ATNState> states = new HashSet<ATNState>();
		for (ATNConfig c : this.elements) {
			states.add(c.state);
		}
		return states;
	}

	@Override
	public String toString() {
		StringBuilder buf = new StringBuilder();
		buf.append(super.toString());
		if ( hasSemanticContext ) buf.append(",hasSemanticContext="+hasSemanticContext);
		if ( uniqueAlt!=ATN.INVALID_ALT_NUMBER ) buf.append(",uniqueAlt="+uniqueAlt);
		if ( conflictingAlts!=null ) buf.append(",conflictingAlts="+conflictingAlts);
		if ( dipsIntoOuterContext ) buf.append(",dipsIntoOuterContext");
		return buf.toString();
	}
}
