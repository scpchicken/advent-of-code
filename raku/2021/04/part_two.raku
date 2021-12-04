use v6.d;

# same as part one 
my (Str $draw-str, Str @board-str-list) = slurp.split("\n\n");

my Str @draw_list = $draw-str.split(",");

my @board-list = @board-str-list.map({
  $^a.split("\n")>>.split(/\s+/, :skip-empty)
});

my Int $total-board = +@board-list;
my Int $curr-win = 0;

my &check-win = -> @board {
  @board.first(-> @line {@line.join eq "X" x 5})
};


for @draw_list -> Str $draw {
  
  # same
  @board-list .= map(-> @board {
    @board.map(-> @line {
      @line.map({$^a eq $draw ?? "X" !! $^a})
    })
  });

  # keep only the boards that haven't won
  @board-list = @board-list.grep(-> @board {

    # var to check if board is still playing
    my Bool $still-playing = True;

    # uses Nil to check if board is won (hori) or the transposed board is won (vert)
    with @board.&check-win || ([Z] @board).&check-win {
      $still-playing = False;
      ++$curr-win;
    }

    # check if the current win count is equal to the total win amount so we know it is the last one
    if $curr-win == $total-board {
      # same
      say $draw * @board>>.List.flat.grep({$^a ne "X"})>>.Int.sum;
      exit
    }

    # return either true or false so the filter knows which one to keep
    $still-playing
  });
}