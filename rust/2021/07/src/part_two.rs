pub fn main(input: &String) {
  let pos_arr: Vec<usize> = input
    .split(",")
    .map(|s| s.parse::<usize>().unwrap())
    .collect();

  let check_pos_vec: Vec<usize> = (pos_arr.clone().into_iter().min().unwrap()..=
    pos_arr.clone().into_iter().max().unwrap())
    .map(|x| x)
    .collect::<Vec<_>>();

  let fuel_arr: Vec<usize> = check_pos_vec
    .into_iter()
    .map(|check_pos| {
      pos_arr
        .clone()
        .into_iter()
        .map(|pos| {
          let diff = (check_pos as isize - pos as isize).abs();

          (diff * (diff + 1) / 2) as usize
        })
        .sum::<usize>()
    })
    .collect::<Vec<_>>();

  println!("{}", fuel_arr.iter().min().unwrap());
}
