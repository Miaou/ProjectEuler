package out;

import java.lang.reflect.Method;
import java.util.BitSet;

import out.utils;
import out.utils.IntArg;

public abstract class ebi_naive {

	public static void main(String[] args) {
		try {
			final IntArg intArg = utils.readInt(args);
			final Method method = ebi_naive.class.getDeclaredMethod("consecutivePrimeSum", int.class);
			utils.statMethod(method, intArg.toString(), intArg.value);
		} catch (NoSuchMethodException | SecurityException e) {
			e.printStackTrace();
			System.exit(utils.ERR_METH_INVOKE);
		}
	}

	public static int consecutivePrimeSum(int lim) {
		// Set bit denote non prime, cleared bit denote prime
		final BitSet primes = getPrimesBelow(lim);
		int topSum = -1;
		int topNbCons = -1;
		for (int p = 2; p <= lim; p = primes.nextClearBit(p + 1)) {
			int sum = 0;
			int nbCons = 0;
			for (int pp = p; p <= lim && sum <= lim; pp = primes.nextClearBit(pp + 1)) {
				sum += pp;
				++nbCons;
				if (sum > lim)
					break;
				if (!primes.get(sum) && (nbCons > topNbCons || (nbCons == topNbCons && sum > topSum))) {
					topNbCons = nbCons;
					topSum = sum;
				}
			}
		}
		return topSum;
	}

	/**
	 * Sieve using a BiteSet object.
	 */
	private static BitSet getPrimesBelow(int lim) {
		final BitSet bitset = new BitSet(lim);
		final double sqrt = Math.sqrt(lim);
		bitset.set(1);
		for (int i = 2; i <= sqrt; i += 1) {
			if (!bitset.get(i)) {
				for (int j = i * i; j < lim; j += i) {
					bitset.set(j);
				}
			}
		}
		return bitset;
	}
}
