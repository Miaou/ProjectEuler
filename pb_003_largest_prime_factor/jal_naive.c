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

long long int compute_rec( long long int n, long long int last_n )
{
  long long int i;
  long long int sqrt_n;
  long double n_d;

  if ( n >= LLONG_MAX )
  {
    printf( "ERROR: Overflow\n");
    return -1;
  }

  n_d = (long double) n;
  sqrt_n = sqrtl( n_d ); 

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


  for ( i = 3; i <= sqrt_n; i = i + 2 )
  {
    long long int j, sqrt_i;

    if ( i % 2 == 0 )
    {
      continue;
    }

    sqrt_i = sqrtl(i);

    for ( j = 3; j <= sqrt_i; j = j + 2 )
    {
      if ( i % j == 0 )
      {
        continue;
      }
    }

    if (n % i == 0)
    {
      return compute_rec( n / i, n );
    }
  }

  return n;
}

int main( int argc, char **argv )
{
  long long int input;

  if( argc != 2 )
  {
    printf( "Give the number for which to compute the greatest prime divisor.\n" );
      return 1;
  }
    
  if( sscanf(argv[1], "%lld", &input) != 1 )
  {
    printf( "Can't read input \"%s\"\n", argv[1] );
    return 2;
  }

  clock_t begin = clock();
  printf("Input   : %lld\n", input );
  printf("Result  : %lld\n", compute_rec( input, input ) );
  clock_t end = clock();
  double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
  printf("Time    : %f ms\n", time_spent * 1000 );

  return 0;
}

