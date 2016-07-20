package out;

import java.lang.reflect.Method;

import out.utils.IntArg;

public abstract class ebi_sieve_boolarray {

	private static int STEP = 1024 * 1024;

	public static void main(String[] args) {
		try {
			final IntArg intArg = utils.readInt(args);
			final Method method = ebi_sieve_boolarray.class.getDeclaredMethod("getNthPrime_BoolArray", int.class);
			utils.statMethod(method, intArg.toString(), intArg.value);
		} catch (NoSuchMethodException | SecurityException e) {
			e.printStackTrace();
			System.exit(utils.ERR_METH_INVOKE);
		}
	}

	/**
	 * Sieve using a boolean array.
	 */
	static int getNthPrime_BoolArray(int nth_prime) {

		int lim = STEP;
		while (lim / Math.log(lim) < nth_prime) {
			lim += STEP;
		}

		boolean[] array = new boolean[lim];
		for (int i = 2; i < Math.sqrt(lim); ++i) {
			if (!array[i]) {
				for (int j = i * i; j < lim; j += i) {
					array[j] = true;
				}
			}
		}

		int nb_primes = 0;
		int index = 2;
		for (; index < lim; index++) {
			if (!array[index]) {
				++nb_primes;
				if (nb_primes == nth_prime)
					return index;
			}
		}

		return -1;
	}
}
