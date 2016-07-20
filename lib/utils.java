package out;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.concurrent.TimeUnit;

public abstract class utils {
	private static int ERR_METH_INVOKE = -1;
	private static int ERR_WRONG_NB_ARGS = -2;
	private static int ERR_INTEGER_WRONG_FMT = -3;

	private static String INP_FMT = "Input  : %s";
	private static String RES_FMT = "Result : %s";
	private static String TIM_FMT = "Time   : %d ms";

	/**
	 * This code perform performance analysis.
	 * 
	 * @param method
	 *            the static method to run
	 * @param input
	 *            the input formatted as a string
	 * @param args
	 *            the arguments to give to the method <code>method</code>
	 */
	public static void statMethod(Method method, String input, Object... args) {
		try {
			long start = System.nanoTime();
			Object res = method.invoke(null, args);
			long end = System.nanoTime();

			System.out.println(String.format(INP_FMT, input));
			System.out.println(String.format(RES_FMT, res.toString()));
			long millis = TimeUnit.NANOSECONDS.toMillis(end - start);
			System.out.println(String.format(TIM_FMT, millis));
		} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
			e.printStackTrace();
			System.exit(ERR_METH_INVOKE);
		}
	}

	/**
	 * Read an array of arguments, and then returns a {@link IntArg}. <br/>
	 * If there is more than one argument given, or if the argument is not an
	 * integer, then the program is exited.
	 * 
	 * @param args
	 *            the array of arguments given to main program
	 * @return an {@link IntArg}
	 */
	public static IntArg readInt(String[] args) {
		int count = args.length;
		if (count != 1) {
			System.err.println(String.format("Exactly one argument is expected (not %d).", count));
			System.exit(ERR_WRONG_NB_ARGS);
		}
		try {
			return new IntArg(Integer.parseInt(args[0]));
		} catch (NumberFormatException e) {
			e.printStackTrace();
			System.exit(ERR_INTEGER_WRONG_FMT);
		}
		return null;
	}

	/**
	 * A useful class for a simple Integer representation.
	 */
	public static class IntArg {
		public int value;

		public IntArg(int value) {
			this.value = value;
		}

		@Override
		public String toString() {
			return Integer.toString(this.value);
		}
	}

}
