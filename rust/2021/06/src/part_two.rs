use std::collections::HashMap;

pub fn main(input: &String) {
  let mut fish_hash: HashMap<isize, isize> = HashMap::new();
  let mut baby_hash: HashMap<isize, isize> = HashMap::new();

  for num in input.split(",") {
    *fish_hash.entry(num.parse::<isize>().unwrap()).or_insert(0) += 1
  }

  for _ in 0..256 {
    fish_hash = fish_hash
      .into_iter()
      .filter(|(k, _)| k > &-1)
      .map(|(k, v)| (k - 1, v))
      .collect::<HashMap<_, _>>();

    for (k, v) in &fish_hash.clone() {
      if k == &-1_isize {
        *fish_hash.entry(6).or_insert(0) += v;
        fish_hash.insert(-1, 0);
        *baby_hash.entry(9).or_insert(0) += v;
      }
    }

    baby_hash = baby_hash
      .into_iter()
      .filter(|(k, _)| k > &-1)
      .map(|(k, v)| (k - 1, v))
      .collect::<HashMap<_, _>>();

    for (k, v) in &baby_hash.clone() {
      if k == &-1_isize {
        *fish_hash.entry(6).or_insert(0) += v;
        baby_hash.insert(-1, 0);
        *baby_hash.entry(8).or_insert(0) += v;
      }
    }
  }

  println!(
    "{}",
    baby_hash.values().sum::<usize>() + fish_hash.values().sum::<usize>()
  );
}
