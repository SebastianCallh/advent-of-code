use std::fs;
use std::str;
use std::collections::HashSet;

fn main() {

    let input = fs::read_to_string("./../../input/Day1.txt").unwrap();
    
    // Task 1
    let changes = input.lines().map(parse_int);
    println!("Answer 1: {}", changes.clone().fold(0, std::ops::Add::add));

    // Task 2
    let mut seen = HashSet::new();
    let thing : Vec<i32> = changes.collect();
    let mut freq = 0;
    for i in 0.. {
        let change = thing[i % thing.len()];
        if seen.contains(&freq) {
            break;
        } else {
            seen.insert(freq);
            freq += change;            
        }
    }
    
    println!("Answer 2: {}", freq);
}

fn parse_int(line : &str) -> i32 {
    line.replace("+", "").parse::<i32>().unwrap()
}

