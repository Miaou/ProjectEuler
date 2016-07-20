package out;

import java.lang.reflect.Method;

import out.utils.IntArg;

public abstract class ebi_sieve_bytearray {

	private static int STEP = 1024 * 1024;

	public static void main(String[] args) {
		try {
			final IntArg intArg = utils.readInt(args);
			final Method method = ebi_sieve_bytearray.class.getDeclaredMethod("getNthPrime_ByteArray", int.class);
			utils.statMethod(method, intArg.toString(), intArg.value);
		} catch (NoSuchMethodException | SecurityException e) {
			e.printStackTrace();
			System.exit(utils.ERR_METH_INVOKE);
		}
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
