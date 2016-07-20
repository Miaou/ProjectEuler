package out;

import java.lang.reflect.Method;

import out.utils.IntArg;

public abstract class ebi_naive {

	public static void main(String[] args) {
		try {
			final IntArg intArg = utils.readInt(args);
			final Method method = ebi_naive.class.getDeclaredMethod("getNthPrime_Naive", int.class);
			utils.statMethod(method, intArg.toString(), intArg.value);
		} catch (NoSuchMethodException | SecurityException e) {
			e.printStackTrace();
			System.exit(utils.ERR_METH_INVOKE);
		}
	}

	/**
	 * Naive way to compute the nth prime number.
	 */
	static int getNthPrime_Naive(int nth_prime) {
		for (int i = 2; i > 0; ++i) {
			int j = 2;
			boolean is_prime = true;
			int sqrt_i = (int) Math.sqrt(i);
			while (j <= sqrt_i && is_prime) {
				is_prime = (i % j) > 0;
				++j;
			}

			if (is_prime) {
				--nth_prime;
				if (nth_prime <= 0)
					return i;
			}
		}

		return -1;
	}
}
