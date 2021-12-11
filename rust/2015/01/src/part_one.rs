pub fn main(input: &String) {
  println!(
    "{}",
    input.chars().filter(|&c| c == '(').count() - input.chars().filter(|&c| c == ')').count()
  )
}
