import java.util.Arrays;
public class Permute2 {
	private int[] a;
	private int n;
	public Permute2(int[] a, int n) {
		this.a = a;
		this.n = n;
	}
	public void permutations() {
		int l = a.length;
		int permutations = (int) Math.pow(l, n);
		int[][] table = new int[permutations][n];

		for (int x = 0; x < n; x++) {
			int t2 = (int) Math.pow(l, x);
			for (int p1 = 0; p1 < permutations;) {
				for (int al = 0; al < l; al++) {
					for (int p2 = 0; p2 < t2; p2++) {
						table[p1][x] = a[al];
						p1++;
					}
				}
			}
		}


		for (int[] permutation : table) {
			action(Arrays.copyOf(permutation, permutation.length));
		}
	}

	public void action(int[] a) {
	}

	public static void main(String[] args) {

		Permute2 gen = new Permute2(new int[] {1,2,3}, 3) {
			@Override
			public void action(int[] a) {
				System.out.println(Arrays.toString(a));
			}
		};
		gen.permutations();
	}
}
