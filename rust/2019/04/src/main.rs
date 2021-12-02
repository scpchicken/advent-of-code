use std::env;

mod part_one;
mod part_two;

fn main() {
  let part: usize = env::args().nth(1).unwrap().parse::<usize>().unwrap();

  let input: String = env::args().nth(2).unwrap();

  match part {
    1 => {
      part_one::main(&input)
    }

    2 => {
      part_two::main(&input)
    }

    _ => {
      panic!("expected numbers 1 or 2")
    }
  }
}

