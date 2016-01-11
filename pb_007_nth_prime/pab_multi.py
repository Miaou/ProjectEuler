#
#

import numba
from itertools import count
import timeit
import argparse
import array



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


def fOptArray(iPrime):
    if iPrime < 1:
        return iPrime
    lPrimes = array.array('I')
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
    
    for sNom, fct in (('pab_naif_py', 'fNaive'),
                      ('pab_opt_py', 'fOpt'),
                      ('pab_naifnumba_py', 'fNaiveNumb'),
                      ('pab_optarray_py', 'fOptArray')):
        print('user {:.3f}s'.format( timeit.timeit('print("{1}({{}}) = {{}}".format({0}, {2}({0})))'.format(args.iPrime, sNom, fct), setup='from __main__ import {}'.format(fct), number=1) ))

