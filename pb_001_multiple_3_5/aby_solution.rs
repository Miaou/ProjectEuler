extern crate utils;

fn main() {
    let limit = match utils::read_int() {
        Ok(value) => value,
        Err(msg) => {
            println!("{}", msg);
            return;
        }
    };

    utils::time(|| -> u64 {
        multiple_sum_up_to(3, limit) + multiple_sum_up_to(5, limit) - multiple_sum_up_to(15, limit)
    }, limit.to_string());
}

fn multiple_sum_up_to(multiple: u64, upto: u64) -> u64 {
    let limit = (upto - 1) / multiple;
    multiple * sum(limit)
}

// Sum(k from 1 to n)
fn sum(n: u64) -> u64 {
    n*(n+1)/2
}
