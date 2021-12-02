use v6.d;

# set curr_x and curr_y to 0 
my $curr_x = 0;
my $curr_y = 0;

# map over the lines after splitting each on space to into to variables direction and amount
lines>>.words.map(-> [$dir, $amount] {
  
  # match dir on
  given $dir {

    # literal "forward"
    when "forward" {

      # increment horizontal distance
      $curr_x += $amount
    }
    
    # literal "up"
    when "up" {

      # decrease depth
      $curr_y -= $amount
    }

    # literal "down"
    when "down" {

      # increase depth
      $curr_y += $amount
    }
  }
});

say $curr_x * $curr_y
