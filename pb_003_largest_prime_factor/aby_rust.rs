use std::env;
use std::time::SystemTime;

fn main() {
    let limit = match env::args().nth(1) {
        Some(text) => match text.parse::<u64>() {
            Ok(value) => value,
            Err(_) => {
                println!("Invalid number: {}", text);
                return;
            }
        },
        None => {
            println!("Missing command line argument");
            return;
        }
    };

    let before = SystemTime::now();
    //let result = largest_prime_factor_sieve(limit);
    let result = largest_prime_factor_nosieve(limit, 2, 1);
    let elapsed = match before.elapsed() {
        Ok(elapsed) => elapsed,
        Err(_) => panic!("Could not get elapsed time")
    };

    println!("Input  : {}", limit);
    println!("Result : {}", result);
    println!("Time   : {}.{:0>#9}s", elapsed.as_secs(), elapsed.subsec_nanos());
}

fn largest_prime_factor_sieve(n: u64) -> u64 {
    let upto = 1 + ((n as f64).sqrt() as u64);
    // We don't have a bitset, a Vec<bool> will do...
    let mut cache: Vec<bool> = Vec::with_capacity(upto as usize);

    let mut remaining: u64 = n;
    let mut largest: u64 = 1;

    unsafe { cache.set_len(upto as usize); }
    for i in 0..cache.len() {
        cache[i] = false;
    }

    for i in 2..(upto as usize) {
        if !&cache[i] {
            // Wooo we have a prime number!

            let prime = i as u64;
            if (remaining % prime) == 0 {
                remaining /= prime;
                largest = prime;
            }

            let mut j = i;

            while j < (upto as usize) {
                cache[j] = true;
                j += i;
            }
        }
    }

    return largest;
}

fn largest_prime_factor_nosieve(n: u64, div: u64, largest: u64) -> u64 {
    if largest >= n {
        return largest;
    }

    if n % div == 0 {
        return largest_prime_factor_nosieve(n/div, div, div)
    }

    return largest_prime_factor_nosieve(n, div + 1, largest)
}
