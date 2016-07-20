package out;

import java.lang.reflect.Method;

import out.utils.IntArg;

public abstract class ebi_naive_opt {

	public static void main(String[] args) {
		try {
			final IntArg intArg = utils.readInt(args);
			final Method method = ebi_naive_opt.class.getDeclaredMethod("getNthPrime_NaiveOpt", int.class);
			utils.statMethod(method, intArg.toString(), intArg.value);
		} catch (NoSuchMethodException | SecurityException e) {
			e.printStackTrace();
			System.exit(utils.ERR_METH_INVOKE);
		}
	}

	/**
	 * Naive way to compute the nth prime number, but storing all primes number
	 * found so far (optimisation).
	 */
	static int getNthPrime_NaiveOpt(int nth_prime) {

		int[] primes = new int[nth_prime];
		int nb_primes = 0;

		for (int i = 2; i > 0; ++i) {
			int sqrt_i = (int) Math.sqrt(i);
			boolean is_prime = true;
			int j = 0;
			while (j < nb_primes && primes[j] <= sqrt_i && is_prime) {
				is_prime = (i % primes[j]) > 0;
				++j;
			}

			if (is_prime) {
				primes[nb_primes] = i;
				++nb_primes;
				if (nb_primes == nth_prime)
					return i;
			}
		}

		return -1;
	}
}
