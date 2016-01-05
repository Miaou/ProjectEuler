#
# Avec cython maintenant...

from itertools import count
import timeit
import argparse



def fNaive(int iPrime):
    cdef:
        int i = 2, j, sq
    if iPrime < 1:
        return iPrime
    #for i in count(2): # Infinite loop
    while True:
        #sq = int(i**.5)+1
        #j = 2
        for j in range(2,int(i**.5)+1):
        #while j<sq:
            if i%j == 0:
                break
        #    j += 1
        else:
            iPrime -= 1
            if iPrime == 0:
                return i
        i += 1

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


if __name__=='__main__':
    parser = argparse.ArgumentParser('Cherchons le nth prime.')
    parser.add_argument('iPrime', metavar='nth_prime', help='indice qui commence à 1', type=int)
    args = parser.parse_args()

    print('user {:.3f}s'.format( timeit.timeit('print("pab_naif_cython({{}}) = {{}}".format({0}, fNaive({0})))'.format(args.iPrime), setup='from pab_naif import fNaive', number=1) ))

