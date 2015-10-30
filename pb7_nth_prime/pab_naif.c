/* 
  Test rapide en C
  Fournir le rang du nombre premier qu'il faut trouver.
   C'est le nième au sens commun du terme (indices commencent à 1)...
*/


#include <stdio.h>
#include <math.h>
#include <stdlib.h>


int fNaive(int iPrime)
{
    int i,j,root;
    int bNotPrime; // I forgot, no bool in C

    if(iPrime < 1)
        return iPrime; // Erreur
    for(i=2; i>0; ++i) // i<0 detects overflow
    {
        root = sqrt(i)+1;
        bNotPrime = 0;
        for(j=2; j<root; ++j) {
            if((i%j) == 0) {
                bNotPrime = 1;
                break;
            }
        }
        if(! bNotPrime && ! --iPrime) // (if prime-1 == 0)
            return i;
    }
    return -1;
}


int fOpt(int iPrime)
{
    int i,j,root,ilP;
    int bNotPrime; // I forgot, no bool in C
    int *lPrimes;

    if(iPrime < 1)
        return iPrime; // Erreur
    
    lPrimes = (int *)malloc(iPrime*sizeof(int));
    for(i=2,ilP=0; i>0; ++i) // i<0 detects overflow
    {
        root = sqrt(i)+1;
        bNotPrime = 0;
        for(j=0; lPrimes[j]<root && j<ilP; ++j) {
            if((i%lPrimes[j]) == 0) {
                bNotPrime = 1;
                break;
            }
        }
        if(! bNotPrime)
        {
            lPrimes[ilP++] = i;
            if(! --iPrime) // (if prime-1 == 0)
            {
                free(lPrimes);
                return i;
            }
        }
    }
    
    free(lPrimes);
    return -1;
}


int main(int argc, char **argv)
{
    int iPrime;

    if(argc != 2)
    {
        printf("Fournir l'index du premier à trouver en argument du programme\n");
        return 1;
    }
    
    if(sscanf(argv[1], "%d", &iPrime) != 1)
    {
        printf("Impossible de lire le numéro du premier dans l'argument \"%s\"\n", argv[1]);
        return 2;
    }

#ifdef OPTIM
    printf("%d: ---> %d <---\n", iPrime, fOpt(iPrime));
#else
    printf("%d: ---> %d <---\n", iPrime, fNaive(iPrime));
#endif
    return 0;
}

