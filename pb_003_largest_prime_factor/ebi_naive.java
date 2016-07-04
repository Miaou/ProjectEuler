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
		long res = highestPrimeFactorDirty(target);
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

	private static int highestPrimeFactorDirty(long x) {
		double sqrt = Math.sqrt(x);
		if (sqrt > Integer.MAX_VALUE)
			return -2;

		int[] primes = getPrimesBelowDirty((int) sqrt + 1);
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
	private static int[] getPrimesBelowDirty(int lim) {

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

	private static long highestPrimeFactorHeapSpace(long x) {
		long[] primes = getPrimesBelowHeapSpace(x);
		if (primes == null) {
			return -2;
		}
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
	private static long[] getPrimesBelowHeapSpace(long lim) {
		final Coordinates coordBitSet = new Coordinates(lim, Integer.MAX_VALUE);
		final int nbBitSet = coordBitSet.getQuotient();
		final int remain = coordBitSet.getRemainder();
		final BitSet[] bitsets = new BitSet[nbBitSet];
		for (int i = 0; i < nbBitSet; ++i) {
			if (i == nbBitSet - 1) {
				bitsets[i] = new BitSet(remain);
			} else {
				bitsets[i] = new BitSet(Integer.MAX_VALUE);
			}
		}

		bitsets[0].set(1);
		for (long curInt = 2; curInt <= Math.sqrt(lim); ++curInt) {
			final Coordinates c = new Coordinates(curInt, Integer.MAX_VALUE);
			boolean isPrime = !bitsets[c.getQuotient() - 1].get(c.getRemainder());
			if (isPrime) {
				for (long nextInt = curInt * curInt; nextInt <= lim; nextInt += curInt) {
					final Coordinates nc = new Coordinates(nextInt, Integer.MAX_VALUE);
					bitsets[nc.getQuotient() - 1].set(nc.getRemainder());
				}
			}
		}

		long lnbPrimes = lim;
		for (int i = 0; i < nbBitSet; ++i) {
			lnbPrimes -= bitsets[i].cardinality();
		}
		if (lnbPrimes > Integer.MAX_VALUE - 5)
			throw new IllegalArgumentException("Too many primes (> Integer.MAX_VALUE - 5).");

		int nbPrimes = (int) lnbPrimes;
		long[] primes = new long[nbPrimes];
		int index = 0;
		for (int i = 0 ; i < nbBitSet ; ++i) {
			for (long p = 2; p <= lim && p >= 0;) {
				primes[index] = p;
				++index;
				int j = (int) p + 1 - (i * Integer.MAX_VALUE);
				p = bitsets[i].nextClearBit(j);
			}
		}
		return primes;
	}

	static class Coordinates {
		private static final String FMT = "(%d, %d)";
		final int quotient;
		final int remainder;

		public Coordinates(long dividend, int divisor) {
			if (divisor == 0)
				throw new IllegalArgumentException("Divisor cannot be 0.");
			if (dividend < 0 || divisor < 0)
				throw new IllegalArgumentException("Dividend and divisor shall both be positive.");

			long lquotient = (dividend + divisor - 1) / divisor;
			long lremainder = dividend - (lquotient * divisor);
			if (lremainder < 0)
				lremainder += divisor;
			if (lquotient > Integer.MAX_VALUE || lremainder > Integer.MAX_VALUE)
				throw new IllegalArgumentException("Quotient and remainder shall both Integer (32 bits).");

			this.quotient = (int) lquotient;
			this.remainder = (int) lremainder;
		}
		
		public int getQuotient() {
			return quotient;
		}

		public int getRemainder() {
			return remainder;
		}

		@Override
		public String toString() {
			return String.format(FMT, quotient, remainder);
		}
	}
}
