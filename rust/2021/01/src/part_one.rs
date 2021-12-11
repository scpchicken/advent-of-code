pub fn main(input: &String) {
  // parse each line into an integer and collect into vector of unsigned int
  let num_vec: Vec<usize> = input.lines().map(|s| s.parse::<usize>().unwrap()).collect();

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
