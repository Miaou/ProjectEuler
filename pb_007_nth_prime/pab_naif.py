#
#

import numba
from itertools import count
import gmpy2
import timeit
import argparse



def fNaive(iPrime):
    if iPrime < 1:
        return iPrime
    for i in count(2): # Infinite loop
        for j in range(2,int(i**.5)+1):#int(gmpy2.isqrt(i))+1): # No gain with isqrt
            if i%j == 0:
                break
        else:
            iPrime -= 1
            if iPrime == 0:
                return i

# Recursive, may not go that far... <- not optimized !!
# Let's store a list... <- not optimzed !!
def fOpt(iPrime):
    if iPrime < 1:
        return iPrime
    lPrimes = []
    for i in count(2): # Infinite loop
        root = int(i**.5)+1
        for j in lPrimes:
            if i%j == 0:
                break
        else:
            iPrime -= 1
            lPrimes.append(i)
            if iPrime == 0:
                return i


# No gain using handmaid int-sqrt
@numba.autojit(nopython=True)
def isqrt(n):
    x = n
    y = (x + 1) // 2
    while y < x:
        x = y
        y = (x + n // x) // 2
    return x

@numba.autojit(nopython=True)
def fNaiveNumb(iPrime):
    if iPrime < 1:
        return iPrime
    i = 2
    while True:
        for j in range(2,int(i**.5)+1):
        #for j in range(2,int(gmpy2.isqrt(i))+1):
        #for j in range(2,isqrt(i)+1):
            if i%j == 0:
                break
        else:
            iPrime -= 1
            if iPrime == 0:
                return i
        i += 1


if __name__=='__main__':
    parser = argparse.ArgumentParser('Cherchons le nth prime.')
    parser.add_argument('iPrime', metavar='nth_prime', help='indice qui commence à 1', type=int)
    args = parser.parse_args()

    print('user {:.3f}s'.format( timeit.timeit('print("pab_naif_py({{}}) = {{}}".format({0}, fNaive({0})))'.format(args.iPrime), setup='from __main__ import fNaive', number=1) ))
    print('user {:.3f}s'.format( timeit.timeit('print("pab_naif_numba({{}}) = {{}}".format({0}, fNaiveNumb({0})))'.format(args.iPrime), setup='from __main__ import fNaiveNumb', number=1) ))

