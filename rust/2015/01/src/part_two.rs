pub fn main(input: &String) {
  println!(
    "{}",
    input
      .chars()
      .map(|c| if c == '(' { 1 } else { -1 })
      .scan(0, |acc, x| {
        *acc = *acc + x;
        Some(*acc)
      })
      .position(|num| num < 0)
      .unwrap()
  )
}
