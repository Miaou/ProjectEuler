package out;

import java.util.BitSet;
import java.util.concurrent.TimeUnit;

public abstract class ebi_naive {

	private static String INP_FMT = "Input  : %d";
	private static String RES_FMT = "Result : %d";
	private static String TIM_FMT = "Time   : %d ms";

	private static class Args {
		final public long target;

		public Args(long target) {
			this.target = target;
		}
	}

	public static void main(String[] args) {
		Args a = parseArgs(args);
		long target = a.target;

		long start = System.nanoTime();
		int res = highestPrimeFactor(target);
		long end = System.nanoTime();

		System.out.println(String.format(INP_FMT, target));
		System.out.println(String.format(RES_FMT, res));
		long millis = TimeUnit.NANOSECONDS.toMillis(end - start);
		System.out.println(String.format(TIM_FMT, millis));
	}

	private static Args parseArgs(String[] args) {
		int count = args.length;
		if (count != 1) {
			System.err.println(String.format("Exactly one argument is expected (not %d).", count));
			System.exit(-1);
		}
		try {
			long l = Long.parseLong(args[0]);
			return new Args(l);
		} catch (NumberFormatException e) {
			e.printStackTrace();
			System.exit(-1);
		}
		return null;
	}

	private static int highestPrimeFactor(long x) {
		double sqrt = Math.sqrt(x);
		if (sqrt > Integer.MAX_VALUE)
			return -2;

		int[] primes = getPrimesBelow((int) sqrt + 1);
		for (int i = primes.length - 1; i >= 0; --i) {
			if (x % primes[i] == 0) {
				return primes[i];
			}
		}
		return -1;
	}

	/**
	 * Sieve using a BiteSet object.
	 */
	private static int[] getPrimesBelow(int lim) {

		final BitSet bitset = new BitSet(lim);
		bitset.set(1);
		for (int i = 2; i <= Math.sqrt(lim); ++i) {
			if (!bitset.get(i)) {
				for (int j = i * i; j < lim; j += i) {
					bitset.set(j);
				}
			}
		}

		int nb_primes = lim - bitset.cardinality(); 
		int[] primes = new int[nb_primes];
		int index = 0;

		for (int p = 2; p <= lim && p >= 0; p = bitset.nextClearBit(p + 1)) {
			primes[index] = p;
			++index;
		}
		return primes;
	}
}
