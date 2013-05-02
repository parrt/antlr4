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



		DoubleKeyMap<PredictionContext,PredictionContext,PredictionContext> mergeCache = null;

		Set<IntArray> skip = new HashSet<IntArray>();
//		skip.add(new IntArray(2,1,1));


		for (int n=1; n<=15; n++) {
//			final List<Integer> nodeCounts = new ArrayList<Integer>();
	//		final List<Integer> edgeCounts = new ArrayList<Integer>();
			MyPermute2 gen = new MyPermute2(n);
			gen.permutations();
//			System.out.println(Collections.max(nodeCounts));
			System.out.println(gen.max);
		}

//		for (int i = 0; i < edgeCounts.size(); i++) {
//			int c = edgeCounts.get(i);
//			if ( i!=0 ) System.out.print(", ");
//			if ( i % 30 == 0 ) System.out.println();
//			System.out.print(c);
//		}
//		System.out.println(edgeCounts);

//		int N = 3;
//		int[] nodes = {1,2,3};
//		for (int i=0; i<N; i++) {
//			for (int j=0; j<N; j++) {
//				for (int k=0; k<N; k++) {
//					int[] s = {nodes[i], nodes[j], nodes[k]};
//					if ( skip.contains(new IntArray(s)) ) continue;
//					PredictionContext seq = configs(s);
//					System.out.println(seq);
//					boolean rootIsWildcard = false;
//
//					List<PredictionContext> allnodes = PredictionContext.getAllContextNodes(ctx);
//					nodeCounts.add(allnodes.size());
//					edgeCounts.add(edgeCount(allnodes));
////					System.out.println("# nodes = "+ allnodes.size()+", # edges = "+edgeCount(allnodes));
//
//					if ( ctx == null ) {
//						ctx = seq;
//					}
//					else {
//						ctx = PredictionContext.merge(ctx, seq, rootIsWildcard, mergeCache);
//					}
//				}
//			}
//		}
//		System.out.println("----------");
//		System.out.println(nodeCounts);
//		System.out.println(edgeCounts);
//		System.out.println(PredictionContext.toDOTString(ctx));
	}

	public static void permute(String beginningString, String endingString) {
		if (endingString.length() <= 1)
			System.out.println(beginningString + endingString);
		else
			for (int i = 0; i < endingString.length(); i++) {
				try {
					String newString = endingString.substring(0, i) + endingString.substring(i + 1);

					permute(beginningString + endingString.charAt(i), newString);
				} catch (StringIndexOutOfBoundsException exception) {
					exception.printStackTrace();
				}
			}
	}

	static void permute(java.util.List<Integer> arr, int k){
		for(int i = k; i < arr.size(); i++){
			java.util.Collections.swap(arr, i, k);
			permute(arr, k+1);
			java.util.Collections.swap(arr, k, i);
		}
		if (k == arr.size() -1){
			System.out.println(java.util.Arrays.toString(arr.toArray()));
		}
	}

	static void allseq(int n) {
		int[] nodes = {1,2,3};
		int[] index = new int[n];
		int[] s = new int[n];
		boolean done = false;
		while ( !done ) {
			for (int i = 0; i < n; i++) {
				s[i] = nodes[index[i]];
				index[i]++;
			}
		}
	}

	static boolean allmax(int[] index, int n) {
		for (int i = 0; i < n; i++) {
			if ( index[i]<n ) return false;
		}
		return true;
	}

	static void foo(int [] nodes, int[] s, int i, int n) {
		if ( i==n ) return;
		for (int j = 0; j < nodes.length; j++) {
			int[] s_ = Arrays.copyOf(s, n);
			s_[i] = nodes[j];
			System.out.println(Arrays.toString(s));
			foo(nodes, s_, i+1, n);
		}
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


	static class MyPermute2 extends Permute2 {
		PredictionContext ctx;
		DoubleKeyMap<PredictionContext,PredictionContext,PredictionContext> mergeCache;
		public int max;

		public MyPermute2(int n) {
			super(new int[]{1, 2, 3}, n);
			ctx = null;
//			mergeCache = new DoubleKeyMap<PredictionContext, PredictionContext, PredictionContext>();
			max = -1;
			System.gc();
//			Runtime runtime = Runtime.getRuntime();
//			System.out.println(runtime.totalMemory()-runtime.freeMemory());
		}

		@Override
		public void action(int[] a) {
//				System.out.println(Arrays.toString(a));
			boolean rootIsWildcard = false;
			int numnodes = PredictionContext.getAllContextNodes(ctx).size();
			if ( numnodes>max ) max = numnodes;
//					nodeCounts.add(numnodes);
//					edgeCounts.add(edgeCount(allnodes));
//				System.out.println("# nodes = "+ allnodes.size()+", # edges = "+edgeCount(allnodes));

			PredictionContext seq = configs(a);
			if ( ctx == null ) {
				ctx = seq;
			}
			else {
				ctx = PredictionContext.merge(ctx, seq, rootIsWildcard, mergeCache);
//				Runtime runtime = Runtime.getRuntime();
//				System.out.println(runtime.totalMemory()-runtime.freeMemory());
			}
		}
	}
}
