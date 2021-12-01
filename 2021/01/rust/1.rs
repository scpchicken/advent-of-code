use std::io::{self, BufRead};

fn main() {
  // get input as vector of usize
  let num_vec = io::stdin()
    .lock()
    .lines()
    .map(|x| x.unwrap().parse::<usize>().unwrap())
    .collect::<Vec<_>>();

  // keep the ones where the next one is greater than the previous one and count how many there are
  println!(
    "{}",
    num_vec
      .iter()
      .zip(&num_vec[1..])
      .filter(|(a, b)| b > a)
      .count()
  )
}
