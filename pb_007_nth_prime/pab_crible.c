/* 
  Test rapide en C
  Fournir le rang du nombre premier qu'il faut trouver.
   C'est le nième au sens commun du terme (indices commencent à 1)...

  Version avec le crible d'eratosthène
*/


#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <limits.h>



int init_crible(long long int iMaxPrime, unsigned char **out)
{
    long long int n = iMaxPrime/8;
    long long int i;

    if(iMaxPrime%8)
        ++n;
    *out = (unsigned char *)malloc(n);
    if(! out)
        return -1;

    for(i=0;i<n;++i)
        (*out)[i] = 0;

    return 0;
}


long long int n_prime(long long int i) // Number of primes between 0 and i
{
    return i/log(i);
}


#define GET_CRIBLE(cb, i)  (cb[i/8]  & (1<<(i%8)))
#define SET_CRIBLE(cb, i)  (cb[i/8] |= (1<<(i%8)))


long long int fCrible(long long int iPrime)
{
    long long int i,j,root,nI;
    long long int bNotPrime;
    unsigned char *crible;
    
    if(iPrime < 1)
        return iPrime; // Erreur
    
    for(nI=0LL; n_prime(nI)<iPrime; nI+=1048576LL);// printf("%lld %lld  %lld\n",nI, n_prime(nI), iPrime);
    printf("Allocating and clearing %lld bytes\n", nI/8);
    if(init_crible(nI, &crible) || ! crible)
    {
        printf("And ... failed!\n");
        return -2;
    }

    //root = sqrt(nI)+1; // On va devoir continuer à les parcourir pour les compter, même si on ne fait rien en pratique...
    for(i=2; i<nI; ++i)
    {
        if(GET_CRIBLE(crible, i)) // Pas premier
            continue;
        // i est premier, on fait ses multiples
        for(j=2*i; j<nI; j+=i) {
            SET_CRIBLE(crible, j);
        }
        // Décompte les premiers, et finit
        if(! --iPrime)
            break;
    }

    if(iPrime) {
        printf("Echec, crible trop petit, reste %lld premiers à trouver alors qu'on est au bout...\n", iPrime);
        return -1;
    }
    return i;
}


int main(int argc, char **argv)
{
    long long int iPrime;

    if(argc != 2)
    {
        printf("Fournir l'index du premier à trouver en argument du programme\n");
        return 1;
    }
    
    if(sscanf(argv[1], "%lld", &iPrime) != 1)
    {
        printf("Impossible de lire le numéro du premier dans l'argument \"%s\"\n", argv[1]);
        return 2;
    }

    printf("%lld: ---> %lld <---\n", iPrime, fCrible(iPrime));
    return 0;
}

