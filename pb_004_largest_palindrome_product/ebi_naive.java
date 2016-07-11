package out;

import java.util.concurrent.TimeUnit;

public abstract class ebi_naive {

	private static String INP_FMT = "Input  : %d";
	private static String RES_FMT = "Result : %d";
	private static String TIM_FMT = "Time   : %d ms";

	private static class Args {
		final public int target;

		public Args(int target) {
			this.target = target;
		}
	}

	public static void main(String[] args) {
		Args a = parseArgs(args);
		int target = a.target;

		long start = System.nanoTime();
		long res = largestPalindrome(target);
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
			int l = Integer.parseInt(args[0]);
			if (l < 1 || l > 16)
				throw new IllegalArgumentException("The number of digit shall be defined between 1 and 16.");
			return new Args(l);
		} catch (NumberFormatException e) {
			e.printStackTrace();
			System.exit(-1);
		}
		return null;
	}

	private static int largestPalindrome(int nbDigit) {
		final int min = (int) Math.pow(10, nbDigit - 1);
		final int max = (int) Math.pow(10, nbDigit) - 1;
		int largestPalindrome = -1;
		for (int i = max ; i >= min ; --i) {
			for (int j = max; j >= i; --j) {
				final int product = i*j;
				if (product < largestPalindrome)
					break;
				if (isPalindrome(product)) {
					largestPalindrome = Math.max(largestPalindrome, product);
					break;
				}
			}
		}
		return largestPalindrome;
	}

	private static boolean isPalindrome(int number) {
		final String str = Integer.toString(number);
		final String rev = new StringBuilder(str).reverse().toString();
		return str.equals(rev);
	}
}
