use std::io::{self, BufRead};

fn main() {
  // same as part 1
  let num_vec = io::stdin()
    .lock()
    .lines()
    .map(|x| x.unwrap().parse::<usize>().unwrap())
    .collect::<Vec<_>>();

  // get windows of 3 (no idea this was a thing lol) then map the sum of each
  let num_window_sum_vec: Vec<usize> = num_vec
    .windows(3)
    .map(|x| x.to_vec().iter().sum())
    .collect();

  // same os part 1
  println!(
    "{}",
    num_window_sum_vec
      .iter()
      .zip(&num_window_sum_vec[1..])
      .filter(|(a, b)| b > a)
      .count()
  )
}
