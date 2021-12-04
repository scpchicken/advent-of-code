use v6.d;

# split input on double newline into bingo drawing string aind list of string boards
my (Str $draw_str, Str @board-str-list) = slurp.split("\n\n");

# convert draw str to list
my Str @draw-list = $draw_str.split(",");

# convert board-str-list to usable list
my @board-list = @board-str-list.map({
  $^a.split("\n")>>.split(/\s+/, :skip-empty)
});

# point block anonymous function that returns whether that board is won or not
my &check-win = -> @board {
  @board.first(-> @line {@line.join eq "X" x 5})
};


# iterate over all bingo drawing list
for @draw-list -> $draw {

  # set all the ones that match that number to X
  @board-list .= map(-> @board {
    @board.map(-> @line {
      @line.map({$^a eq $draw ?? "X" !! $^a})
    })
  });
  
  # iterate over all boards
  @board-list.map(-> @board {

    # do a nil check and check whether the board is won (hori) or the transposed board is won (verti)
    with @board.&check-win || ([Z] @board).&check-win {

      # filter the "X" from the winning board and calculate the score
      say $draw * @board>>.List.flat.grep({$^a ne "X"}).sum;
      exit
    }
  })
}