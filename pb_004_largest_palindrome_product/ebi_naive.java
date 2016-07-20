package out;

import java.lang.reflect.Method;

import out.utils.IntArg;

public abstract class ebi_naive {

	public static void main(String[] args) {
		try {
			final IntArg intArg = utils.readInt(args);
			final Method method = ebi_naive.class.getDeclaredMethod("largestPalindrome", int.class);
			utils.statMethod(method, intArg.toString(), intArg.value);
		} catch (NoSuchMethodException | SecurityException e) {
			e.printStackTrace();
			System.exit(6);
		}
	}

	public static long largestPalindrome(int nbDigit) {
		final int min = (int) Math.pow(10, nbDigit - 1);
		final int max = (int) Math.pow(10, nbDigit) - 1;
		long largestPalindrome = -1L;
		for (long i = max ; i >= min ; --i) {
			for (long j = max; j >= i; --j) {
				long product = i*j;
				if (product < largestPalindrome)
					break;
				if (isPalindrome(product)) {
					largestPalindrome = product;
					break;
				}
			}
		}
		return largestPalindrome;
	}

	private static boolean isPalindrome(long number) {
		final String str = Long.toString(number);
		final String rev = new StringBuilder(str).reverse().toString();
		return str.equals(rev);
	}
}
