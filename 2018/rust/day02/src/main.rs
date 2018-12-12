use std::fs;

fn main() {
    let input = fs::read_to_string("./../../input/Day2.txt").unwrap();
    let lines = input.lines();
    let min_dist : (i32, i32) = (std::i32::MAX, std::i32::MAX);
    println!("{:?}", "hejhej".chars().);
    println!("cartesian product: {:?}", cartesian_product(&['a', 'b', 'c'], &['d', 'e', 'f']));
        
//    println!("cartesian product: {:?}", 
    
/*    for x in lines.take(10) {
        for y in lines {
            println!("{}", hamming_dist(&['a', 'b', 'c', 'd'], &['a', 'b', 'c', 'd']));
        }
    }*/
}

fn hamming_dist(arr1: &[char], arr2: &[char]) -> i32 {    
    arr1.iter().zip(arr2.iter())
        .fold(0, |acc, (x, y)| {
            if x != y {
                acc + 1 
            } else {
                acc
            }
        })
}

fn cartesian_product<'a, T>(arr1: &'a [T], arr2: &'a [T]) -> Vec<(&'a T, &'a T)> {
    let mut prod = Vec::new();
    for x in arr1 {
        for y in arr2 {
            prod.push((x, y));
        }
    }
    prod
}
