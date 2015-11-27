package out;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.BitSet;
import java.util.List;
import java.util.concurrent.TimeUnit;

public abstract class ebi_all {

	private static int STEP = 1024 * 1024;
	private static String INP_FMT = "Input  : %d";
	private static String RES_FMT = "Result : %d";
	private static String TIM_FMT = "Time   : %d ms";

	private static class Args {
		public int nth;
		public Method method;

		public Args(int nth, Method method) {
			super();
			this.nth = nth;
			this.method = method;
		}
	}

	public static void main(String[] args) {
		Args a = parseArgs(args);
		Method m = a.method;
		int nth = a.nth;
		int nth_prime = -1;

		long start = System.nanoTime();
		try {
			nth_prime = (int) m.invoke(null, nth);
		} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
			e.printStackTrace();
		}
		long end = System.nanoTime();

		System.out.println(String.format(INP_FMT, nth));
		System.out.println(String.format(RES_FMT, nth_prime));
		long millis = TimeUnit.NANOSECONDS.toMillis(end - start);
		System.out.println(String.format(TIM_FMT, millis));
	}

	private static Args parseArgs(String[] args) {
		int count = args.length;
		if (count != 2) {
			System.err.println(String.format("Exactly two arguments are expected (not %d).", count));
			System.exit(-1);
		}
		try {
			Method method = ebi_all.class.getDeclaredMethod("getNthPrime_" + args[0], int.class);
			int nth = Integer.parseInt(args[1]);

			if (nth < 1) {
				System.err.println("The integer shall be > 0.");
				System.exit(-2);
			}
			return new Args(nth, method);
		} catch (NumberFormatException e) {
			e.printStackTrace();
			System.exit(-3);
		} catch (NoSuchMethodException | SecurityException e) {
			e.printStackTrace();
			System.exit(-4);
		}
		return null;
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

	/**
	 * Sieve using a Byte array.
	 */
	static int getNthPrime_ByteArray(int nth_prime) {

		int lim = STEP;
		while (lim / Math.log(lim) < nth_prime) {
			lim += STEP;
		}

		byte[] array = new byte[lim / 8];
		for (int i = 2; i < Math.sqrt(lim); ++i) {
			if (!getBit(array, i)) {
				for (int j = i * i; j < lim; j += i) {
					setBit(array, j);
				}
			}
		}

		int nb_primes = 0;
		int index = 2;
		for (; index < lim; index++) {
			if (!getBit(array, index)) {
				++nb_primes;
				if (nb_primes == nth_prime)
					return index;
			}
		}
		return -1;
	}

	private static void setBit(byte[] array, int index) {
		int byte_index = index >> 3;
		int mask = 1 << (index & 7);
		byte b = (byte) (array[byte_index] | mask);
		array[byte_index] = b;
	}

	private static boolean getBit(byte[] array, int index) {
		int byte_index = index >> 3;
		int mask = 1 << (index & 7);
		return (array[byte_index] & mask) != 0;
	}
}
