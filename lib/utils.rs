use std::env;
use std::time::SystemTime;

pub fn read_int() -> Result<u64, &'static str> {
    match env::args().nth(1) {
        Some(text) => match text.parse::<u64>() {
            Ok(value) => Ok(value),
            Err(_) => Err("Invalid number")
        },
        None => {
            Err("Missing command line argument")
        }
    }
}

pub fn time<F, T>(f: F, input_desc: String) where
    F: Fn() -> T,
    T: std::fmt::Display
{
    let before = SystemTime::now();
    let result = f();
    let elapsed = match before.elapsed() {
        Ok(elapsed) => elapsed,
        Err(_) => panic!("Could not get elapsed time")
    };

    println!("Input  : {}", input_desc);
    println!("Result : {}", result);
    println!("Time   : {}.{:0>#9}s", elapsed.as_secs(), elapsed.subsec_nanos());
}
