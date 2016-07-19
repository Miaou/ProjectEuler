/*
 * Euler Problem no 3
 *
 * Find the largest prime divisor of a given number.
 */

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <limits.h>
#include <time.h>

unsigned long long int compute_rec( unsigned long long int n, unsigned long long int last_n )
{
  unsigned long long int i;
  unsigned long long int sqrt_n;
  long double n_d;
  int prime_div;

  if ( n >= ULLONG_MAX )
  {
    printf( "ERROR: Overflow\n");
    return -1;
  }

  n_d = (long double) n;

  if ( n == 2 )
  {
    return n;
  }

  if ( n <= 2 )
  {
    return last_n;
  }

  if ( n % 2 == 0 )
  {
    return compute_rec( n / 2, n );
  }

  sqrt_n = sqrtl( n_d );

  for ( i = 3; i <= sqrt_n; i = i + 2 )
  {
    if ( n % i == 0 )
    {
#if 1
      unsigned long long int toto = n / i;

      while ( toto % i == 0 )
      {
        toto = toto / i ;
      }
      return compute_rec( toto, toto * i );
#else
      return compute_rec( n / i , n );
#endif
    }
  }

  return n;
}

int main( int argc, char **argv )
{
  unsigned long long int input;

  if( argc != 2 )
  {
    printf( "Give the number for which to compute the greatest prime divisor.\n" );
      return 1;
  }

  if( sscanf(argv[1], "%llu", &input) != 1 )
  {
    printf( "Can't read input \"%s\"\n", argv[1] );
    return 2;
  }

  clock_t begin = clock();
  printf("Input   : %llu\n", input );
  printf("Result  : %llu\n", compute_rec( input, input ) );
  clock_t end = clock();
  double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
  printf("Time    : %f ms\n", time_spent * 1000 );

  return 0;
}

