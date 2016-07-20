package out;

import java.lang.reflect.Method;
import java.util.BitSet;

import out.utils.IntArg;

public abstract class ebi_sieve_bitset {

	private static int STEP = 1024 * 1024;

	public static void main(String[] args) {
		try {
			final IntArg intArg = utils.readInt(args);
			final Method method = ebi_sieve_bitset.class.getDeclaredMethod("getNthPrime_BiteSet", int.class);
			utils.statMethod(method, intArg.toString(), intArg.value);
		} catch (NoSuchMethodException | SecurityException e) {
			e.printStackTrace();
			System.exit(utils.ERR_METH_INVOKE);
		}
	}

	/**
	 * Sieve using a BiteSet object.
	 */
	static int getNthPrime_BiteSet(int nth_prime) {

		int lim = STEP;
		while (lim / Math.log(lim) < nth_prime) {
			lim += STEP;
		}

		final BitSet bitset = new BitSet(lim);
		for (int i = 2; i < Math.sqrt(lim); ++i) {
			if (!bitset.get(i)) {
				for (int j = i * i; j < lim; j += i) {
					bitset.set(j);
				}
			}
		}

		int nb_primes = 0;
		for (int index = 2; index < lim && index >= 0; index = bitset.nextClearBit(index + 1)) {
			++nb_primes;
			if (nb_primes == nth_prime)
				return index;
		}
		return -1;
	}
}
