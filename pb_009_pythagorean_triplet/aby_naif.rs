extern crate utils;

fn main() {
    println!("Array based");
    utils::time(|| -> String {
        let (a, b, c) = find_abc_array();
        format!("{} {} {}", a, b, c)
    }, "1000");

    println!("\nComputation based");
    utils::time(|| -> String {
        let (a, b, c) = find_abc_compute();
        format!("{} {} {}", a, b, c)
    }, "1000");
}

fn find<F>(testfunc: F) -> (u64, u64, u64) where F: Fn(usize, usize, usize) -> bool {
    for c in (2..1000).rev() {
        for b in (2..c).rev() {
            if c + b >= 1000 {
                continue;
            }

            for a in (2..b).rev() {
                let sum = a + b + c;

                if sum < 1000 {
                    break;
                }

                if (sum == 1000) && testfunc(a, b, c) {
                    return (a as u64, b as u64, c as u64);
                }
            }
        }
    }

    return (0, 0, 0);
}

fn find_abc_array() -> (u64, u64, u64) {
    let mut squares: [u64; 1000] = [0; 1000];

    for i in 0..squares.len() {
        squares[i] = (i*i) as u64;
    }

    find(|a, b, c| { squares[a] + squares[b] == squares[c]})
}

fn find_abc_compute() -> (u64, u64, u64) {
    find(|a, b, c| { a*a + b*b == c*c })
}
