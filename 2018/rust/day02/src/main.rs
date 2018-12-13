use std::fs;
use std::collections::HashMap;

fn main() {
    let input = fs::read_to_string("./../../input/Day2.txt").unwrap();
    let lines : Vec<_> = input.lines().map(|l| String::from(l)).collect();
    let mut min_sim = String::from("");

    // Part 1
    let (twos, threes) = lines.iter()
        .fold((0, 0), |(twoes, threes), line| {
            let map = line.chars()
                .fold(HashMap::new(), |mut counts, chr| {
                    *counts.entry(chr).or_insert(0) += 1;
                    counts
                });
            let contains_two   = map.values().any(|&c| c == 2);
            let contains_three = map.values().any(|&c| c == 3);
            (if contains_two   { twoes  + 1 } else { twoes },
             if contains_three { threes + 1 } else { threes })
        });

    println!("Answer part 1: {}", twos * threes);
    
    // Part 2
    for x in &lines {
        for y in &lines {
            let cur_sim = hamming_sim(x, y);
            if cur_sim.len() + 1 == x.len() {
                min_sim = cur_sim;
            }
        }
    }
    
    println!("Answer part 2: {:?}", min_sim);
}

fn hamming_sim(str1: &str, str2: &str) -> String {
    str1.chars().zip(str2.chars())
        .fold(String::new(), |mut acc, (x, y)| {
            if x == y {
                acc.push(x);
            }
            acc
        })
}
