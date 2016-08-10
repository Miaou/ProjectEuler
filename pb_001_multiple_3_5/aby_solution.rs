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
    let result = multiple_sum_up_to(3, limit) + multiple_sum_up_to(5, limit) - multiple_sum_up_to(15, limit);
    let elapsed = match before.elapsed() {
        Ok(elapsed) => elapsed,
        Err(_) => panic!("Could not get elapsed time")
    };

    println!("Input  : {}", limit);
    println!("Result : {}", result);
    println!("Time   : {}.{:0>#9}s", elapsed.as_secs(), elapsed.subsec_nanos());
}

fn multiple_sum_up_to(multiple: u64, upto: u64) -> u64 {
    let limit = (upto - 1) / multiple;
    multiple * sum(limit)
}

// Sum(k from 1 to n)
fn sum(n: u64) -> u64 {
    n*(n+1)/2
}
