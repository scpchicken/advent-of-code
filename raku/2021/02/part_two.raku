use v6.d;

# set curr_x, curr_y, and aim to 0
my $curr_x = 0;
my $curr_y = 0;
my $aim = 0;

# map the lines after mapping split into two variables direction and amount
lines>>.words.map(-> [$dir, $amount] {

  # match dir on
  given $dir {

    # literal "forward"
    when "forward" {

      # add to horizontal direction and depth
      $curr_x += $amount;
      $curr_y += $aim * $amount
    }

    # literal "up"
    when "up" {
      
      # decrease aim
      $aim -= $amount
    }

    # literal "down"
    when "down" {

      # increase aim
      $aim += $amount
    }
  }
});

# print out the product of the depth and horizontal distance
say $curr_x * $curr_y
