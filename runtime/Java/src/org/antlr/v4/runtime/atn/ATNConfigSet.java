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
 */
public class ATNConfigSet extends OrderedHashSet<ATNConfig> {
	public boolean fullCtx;

	// TODO: these fields make me pretty uncomfortable but nice to pack up info together, saves recomputation
	// TODO: can we track conflicts as they are added to save scanning configs later?
	public int uniqueAlt;
	public IntervalSet conflictingAlts;
	public boolean hasSemanticContext;
	public boolean dipsIntoOuterContext;

	public ATNConfigSet() { this(true); }
	public ATNConfigSet(boolean fullCtx) { this.fullCtx = fullCtx; }

	@Override
	public Object clone() {
		return new ATNConfigSet(this);
	}

	public ATNConfigSet(ATNConfigSet old) {
		addAll(old);
		this.fullCtx = old.fullCtx;
		this.uniqueAlt = old.uniqueAlt;
		this.conflictingAlts = old.conflictingAlts;
		this.hasSemanticContext = old.hasSemanticContext;
		this.dipsIntoOuterContext = old.dipsIntoOuterContext;
	}

	/** Only add configs that aren't suffixes of an existing with same
	 *  state and alt. So, if (1, 2, [10]) exists, don't add (1, 2, [10 4])
	 *  since 10 is suffix of [10 4].  If reverse and (1, 2, [10 4]) exists,
	 *  and we try to add config (1, 2, [10]), delete existing and add shorter
	 *  one.
	 *
	 *  In full ctx, we check equals for stacks not suffix so always add.
	 *
	 *  Don't add of course if value is already a member.
	 */
	@Override
	public boolean add(ATNConfig value) {
		if ( fullCtx ) return super.add(value);
		for (ATNConfig c : this) {
			if ( c.state==value.state && c.alt==value.alt ) {
				// don't check equals(); super.add() will do that.
				if ( value.context.suffix(c.context) ) {
					System.out.println("not adding");
					return false;
				}
			}
		}
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
