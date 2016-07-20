package out;

import java.lang.reflect.Method;
import java.util.BitSet;

import out.utils.LongArg;

public abstract class ebi_naive {


	public static void main(String[] args) {
		try {
			final LongArg longArg = utils.readLong(args);
			final Method method = ebi_naive.class.getDeclaredMethod("highestPrimeFactor", long.class);
			utils.statMethod(method, longArg.toString(), longArg.value);
		} catch (NoSuchMethodException | SecurityException e) {
			e.printStackTrace();
			System.exit(utils.ERR_METH_INVOKE);
		}
	}

	public static long highestPrimeFactor(long x) {
		double sqrt = Math.sqrt(x);
		if (sqrt > Integer.MAX_VALUE)
			return -2;

		int[] primes = getPrimesBelow((int) sqrt + 1);
		long hp = -1;
		for (int i = 0; i < primes.length; ++i) {
			int p = primes[i];
			while (x % p == 0) {
				hp = p;
				x /= p;
			}
		}
		if (x != 1)
			return x;
		return hp;
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
