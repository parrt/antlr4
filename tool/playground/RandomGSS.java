import org.antlr.v4.runtime.atn.ATNConfig;
import org.antlr.v4.runtime.atn.ATNState;
import org.antlr.v4.runtime.atn.BasicState;
import org.antlr.v4.runtime.atn.PredictionContext;
import org.antlr.v4.runtime.atn.SingletonPredictionContext;
import org.antlr.v4.runtime.misc.DoubleKeyMap;

public class RandomGSS {
	public static void main(String[] args) {
		int TRIALS = 5;
		int N = 20;
		int[] nodes = { 1, 2, 3, 4 };
		for (int n=1; n<=N; n++) {
			System.out.print("n = " + n + ", ");
			PredictionContext ctx = PredictionContext.EMPTY;
			int max = -1;
			for (int trial=1; trial<=TRIALS; trial++) {
				DoubleKeyMap<PredictionContext,PredictionContext,PredictionContext> mergeCache =
					new DoubleKeyMap<PredictionContext, PredictionContext, PredictionContext>();
				System.out.println("trial "+trial);
				int[] seq = getRandomPermutation(nodes, n);
				PredictionContext next = stack(seq);
//			System.out.println(Arrays.toString(seq));
				boolean rootIsWildcard = false;
				ctx = PredictionContext.merge(ctx, next, rootIsWildcard, mergeCache);
				int numnodes = PredictionContext.getAllContextNodes(ctx).size();
				System.out.println("nodes = "+numnodes);
				if ( numnodes>max ) max = numnodes;
			}
		}
	}

	public static int[] getRandomPermutation(int[] a, int n) {
		int[] seq = new int[n];
		for (int i=1; i<=n; i++) {
			int r = (int)Math.round(Math.random()*(a.length-1));
			seq[i-1] = a[r];
		}
		return seq;
	}

	static PredictionContext stack(int[] seq) {
		PredictionContext ctx = PredictionContext.EMPTY;
		for (int i=seq.length-1; i>=0; i--) {
			ctx = SingletonPredictionContext.create(ctx, seq[i]);
		}
		return ctx;
	}

	protected static ATNConfig config(int s, PredictionContext ctx) {
		ATNState p = new BasicState();
		p.stateNumber = s;
		int i = 0;
		return new ATNConfig(p, i, ctx);
	}
}
