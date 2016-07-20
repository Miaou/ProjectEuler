package out;

import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.List;

import out.utils.IntArg;

public abstract class ebi_sieve_boollist {

	private static int STEP = 1024 * 1024;

	public static void main(String[] args) {
		try {
			final IntArg intArg = utils.readInt(args);
			final Method method = ebi_sieve_boollist.class.getDeclaredMethod("getNthPrime_BoolList", int.class);
			utils.statMethod(method, intArg.toString(), intArg.value);
		} catch (NoSuchMethodException | SecurityException e) {
			e.printStackTrace();
			System.exit(utils.ERR_METH_INVOKE);
		}
	}

	/**
	 * Sieve using a Boolean list.
	 */
	static int getNthPrime_BoolList(int nth_prime) {

		int lim = STEP;
		while (lim / Math.log(lim) < nth_prime) {
			lim += STEP;
		}

		Boolean[] array = new Boolean[lim];
		final List<Boolean> list = Arrays.asList(array);
		for (int i = 2; i < Math.sqrt(lim); ++i) {
			if (list.get(i) == null) {
				for (int j = i * i; j < lim; j += i) {
					list.set(j, true);
				}
			}
		}

		int nb_primes = 0;
		int index = 2;
		for (; index < lim; index++) {
			if (list.get(index) == null) {
				++nb_primes;
				if (nb_primes == nth_prime)
					return index;
			}
		}
		return -1;
	}
}
