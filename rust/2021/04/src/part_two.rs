use regex::Regex;

fn check_win(board: &Vec<Vec<String>>) -> bool {
  match board.into_iter().find(|line| line.join("") == "XXXXX") {
    Some(_) => true,
    None => false,
  }
}

fn transpose(board: &Vec<Vec<String>>) -> Vec<Vec<String>> {
  let mut transposed_board = vec![vec![]; board[0].len()];

  for line in board {
    for (ind, item) in (0..).zip(line.iter()) {
      transposed_board[ind].push(item.to_string())
    }
  }

  transposed_board
}

pub fn main(input: &String) {
  let space_regex = Regex::new(r"\s+").unwrap();
  let input_chunk_vec: Vec<String> = input.split("\n\n").map(|s| s.to_string()).collect();
  let draw_vec: Vec<String> = input_chunk_vec[0]
    .split(",")
    .map(|s| s.to_string())
    .collect();
  let board_vec = input_chunk_vec[1..].to_vec();
  let mut board_vec = board_vec
    .iter()
    .map(|board_str| {
      board_str
        .split("\n")
        .map(|board_str_vec| {
          space_regex
            .split(board_str_vec)
            .filter(|s| s != &"")
            .map(|s| s.to_string())
            .collect::<Vec<_>>()
        })
        .collect::<Vec<_>>()
    })
    .collect::<Vec<_>>();

  let board_count = board_vec.len();
  let mut board_win_count = 0;

  // println!("{:#?}\n\n", board_vec);

  for draw in draw_vec {
    board_vec = board_vec
      .iter()
      .map(|board| {
        board
          .iter()
          .map(|line| {
            line
              .iter()
              .map(|s| {
                if s == &draw {
                  "X".to_string()
                } else {
                  s.to_string()
                }
              })
              .collect::<Vec<_>>()
          })
          .collect::<Vec<_>>()
      })
      .filter(|board| {
        if check_win(&board) || check_win(&transpose(&board)) {
          board_win_count += 1;
          if board_win_count == board_count {
            println!("{}", draw);
            println!(
              "{}",
              draw.parse::<usize>().unwrap() *
                board
                  .into_iter()
                  .flatten()
                  .filter_map(|s| match s.parse::<usize>() {
                    Ok(num) => Some(num),
                    Err(_) => None,
                  })
                  .sum::<usize>()
            );
            std::process::exit(69);
          }
          false
        } else {
          true
        }
      })
      .collect::<Vec<_>>();

    // println!("{}", board_vec.len());
    // for board in board_vec.clone() {
    //   // println!("{:?}", board);
    //   if check_win(&board) || check_win(&transpose(&board)) {
    //     println!(
    //       "{}",
    //       draw.parse::<usize>().unwrap() *
    //         board
    //           .into_iter()
    //           .flatten()
    //           .filter_map(|s| match s.parse::<usize>() {
    //             Ok(num) => Some(num),
    //             Err(_) => None,
    //           })
    //           .sum::<usize>()
    //     );

    //     std::process::exit(69);
    //   }
    // }
  }
}
