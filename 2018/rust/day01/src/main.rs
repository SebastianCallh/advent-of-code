use std::fs;
use std::str;
use std::collections::HashSet;

fn main() {

    let input = fs::read_to_string("./../../input/Day1.txt").unwrap();
    
    // Task 1
    let changes : Vec<_> = input.lines().map(parse_int).collect();
    let sum : i32 = changes.iter().sum();
    println!("Answer part 1: {}", sum);

    // Task 2
    let mut seen = HashSet::new();
    let mut freq = 0;
    for i in 0.. {
        let change = changes[i % changes.len()];
        if seen.contains(&freq) {
            break;
        } else {
            seen.insert(freq);
            freq += change;            
        }
    }
    
    println!("Answer part 2: {}", freq);
}

fn parse_int(line : &str) -> i32 {
    line.replace("+", "").parse::<i32>().unwrap()
}

