#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <limits.h>
#include <stdint.h>

int init_crible(unsigned long long int iMaxPrime, unsigned char **out)
{
    unsigned long long int n = (iMaxPrime + 7)/8;
    unsigned long long int i;

    *out = (unsigned char *)malloc(n);
    if(! out)
        return -1;

    for(i=0 ; i<n ; ++i)
        (*out)[i] = 0;

    return 0;
}

#define GET_CRIBLE(cb, i)  (cb[i/8]  & (1<<(i%8)))
#define SET_CRIBLE(cb, i)  (cb[i/8] |= (1<<(i%8)))

unsigned long long int smallestMultiple(unsigned long long int target)
{
    unsigned long long int i, j, root, nI;
    unsigned long long int res;
    unsigned char *crible;

    res = 1LL;
    if(target < 2)
        return -1;

    if(init_crible(nI, &crible) || ! crible)
    {
        printf("Failed to initialise the array of primes.\n");
        return -2;
    }

    for(i=2; i<=target; ++i)
    {
        if(GET_CRIBLE(crible, i))
            continue;
        for(j=i ; j<=target; j*=i)
            res *= i;
        for(j=2*i; j<=target; j+=i)
            SET_CRIBLE(crible, j);
    }

    return res;
}


int main(int argc, char **argv)
{
    unsigned long long int iPrime;

    if(argc != 2)
    {
        printf("This program takes exactly one arguments (a positive integer).\n");
        return 1;
    }
    
    if(sscanf(argv[1], "%lld", &iPrime) != 1)
    {
        printf("Could not read the input ('%s').\n", argv[1]);
        return 2;
    }

    printf("%lld: ---> %llu <---\n", iPrime, smallestMultiple(iPrime));
    return 0;
}

