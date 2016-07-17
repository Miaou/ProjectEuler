package out;

import java.util.BitSet;
import java.util.concurrent.TimeUnit;

public abstract class ebi_naive {

	private static String INP_FMT = "Input  : %d";
	private static String RES_FMT = "Result : %d";
	private static String TIM_FMT = "Time   : %d ms";

	private static class Args {
		final public int target;

		public Args(int target) {
			this.target = target;
		}
	}

	public static void main(String[] args) {
		Args a = parseArgs(args);
		int target = a.target;

		long start = System.nanoTime();
		int res = consecutivePrimeSum(target);
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
			int l = Integer.parseInt(args[0]);
			return new Args(l);
		} catch (NumberFormatException e) {
			e.printStackTrace();
			System.exit(-1);
		}
		return null;
	}

	private static int consecutivePrimeSum(int lim) {
		// Set bit denote non prime, cleared bit denote prime
		final BitSet primes = getPrimesBelow(lim);
		int topSum = -1;
		int topNbCons = -1;
		for (int p = 2; p <= lim; p = primes.nextClearBit(p + 1)) {
			int sum = 0;
			int nbCons = 0;
			for (int pp = p; p <= lim && sum <= lim; pp = primes.nextClearBit(pp + 1)) {
				sum += pp;
				++nbCons;
				if (sum > lim)
					break;
				if (!primes.get(sum) && (nbCons > topNbCons || (nbCons == topNbCons && sum > topSum))) {
					topNbCons = nbCons;
					topSum = sum;
				}
			}
		}
		return topSum;
	}

	/**
	 * Sieve using a BiteSet object.
	 */
	private static BitSet getPrimesBelow(int lim) {
		final BitSet bitset = new BitSet(lim);
		bitset.set(1);
		for (int i = 2; i <= Math.sqrt(lim); ++i) {
			if (!bitset.get(i)) {
				for (int j = i * i; j < lim; j += i) {
					bitset.set(j);
				}
			}
		}
		return bitset;
	}
}
