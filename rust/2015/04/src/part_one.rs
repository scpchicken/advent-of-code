use md5;

pub fn main(input: &String) {
  let key = input;

  for check_num in 0.. {
    let check_str = format!("{}{}", key, check_num);
    if format!("{:x}", md5::compute(check_str)).starts_with("00000") {
      println!("{}", check_num);
      std::process::exit(69);
    }
  }
}
