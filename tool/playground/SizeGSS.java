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

import org.antlr.v4.runtime.atn.ATNConfig;
import org.antlr.v4.runtime.atn.ATNState;
import org.antlr.v4.runtime.atn.BasicState;
import org.antlr.v4.runtime.atn.PredictionContext;
import org.antlr.v4.runtime.atn.SingletonPredictionContext;
import org.antlr.v4.runtime.misc.DoubleKeyMap;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class SizeGSS {
	static class IntArray {
		int[] data;

		public IntArray(int a, int b, int c) { this(new int[] {a,b,c}); }
		public IntArray(int[] data) {this.data = data;}

		@Override
		public int hashCode() {
			return Arrays.hashCode(data);
		}

		@Override
		public boolean equals(Object obj) {
			return Arrays.equals(this.data, ((IntArray)obj).data);
		}
	}

	public static void main(String[] args) {
//		ATNConfig c = config(1);
		PredictionContext newContext =
			SingletonPredictionContext.create(PredictionContext.EMPTY, 2);

		PredictionContext ctx = null;

		DoubleKeyMap<PredictionContext,PredictionContext,PredictionContext> mergeCache = null;

		Set<IntArray> skip = new HashSet<IntArray>();
//		skip.add(new IntArray(2,1,1));

		List<Integer> nodeCounts = new ArrayList<Integer>();
		List<Integer> edgeCounts = new ArrayList<Integer>();

		int N = 3;
		int[] nodes = {1,2,3};
		for (int i=0; i<N; i++) {
			for (int j=0; j<N; j++) {
				for (int k=0; k<N; k++) {
					int[] s = {nodes[i], nodes[j], nodes[k]};
					if ( skip.contains(new IntArray(s)) ) continue;
					PredictionContext seq = configs(s);
					System.out.println(seq);
					boolean rootIsWildcard = false;

					List<PredictionContext> allnodes = PredictionContext.getAllContextNodes(ctx);
					nodeCounts.add(allnodes.size());
					edgeCounts.add(edgeCount(allnodes));
//					System.out.println("# nodes = "+ allnodes.size()+", # edges = "+edgeCount(allnodes));

					if ( ctx == null ) {
						ctx = seq;
					}
					else {
						ctx = PredictionContext.merge(ctx, seq, rootIsWildcard, mergeCache);
					}
				}
			}
		}
		System.out.println("----------");
		System.out.println(nodeCounts);
		System.out.println(edgeCounts);
		System.out.println(PredictionContext.toDOTString(ctx));
	}

	static PredictionContext configs(int[] seq) {
		PredictionContext ctx = PredictionContext.EMPTY;
		for (int i=seq.length-1; i>=0; i--) {
			ctx = SingletonPredictionContext.create(ctx, seq[i]);
		}
		return ctx;
	}

	protected static ATNConfig config(int s) {
		return config(s, PredictionContext.EMPTY);
	}

	protected static ATNConfig config(int s, PredictionContext ctx) {
		ATNState p = new BasicState();
		p.stateNumber = s;
		int i = 0;
		return new ATNConfig(p, i, ctx);
	}

	public static int edgeCount(List<PredictionContext> nodes) {
		int n = 0;
		for (PredictionContext current : nodes) {
			n += current.size();
		}
		return n;
	}
}
