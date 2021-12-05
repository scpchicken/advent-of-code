use v6.d;

# split lines into coordinate pairings
my Array:D @coord-list = lines.map(-> $line {
  $line.split(" -> ").map(-> $coord {
    $coord.split(",")>>.Int
  }).Array
});

# filter out all the ones that are not straight lines
@coord-list = @coord-list.grep(-> [[UInt:D $j-a, UInt:D $i-a], [UInt:D $j-b, UInt:D $i-b]] {
  [$j-a == $j-b, $i-a == $i-b].any
});

# make a list of 1000 x 1000
my Array:D @ocean-floor-list = [0 xx 1000] xx 1000;

# fill that 1000 x 1000 list with the inputs
for @coord-list -> [[UInt:D $j-a, UInt:D $i-a], [UInt:D $j-b, UInt:D $i-b]] {
  if $j-a == $j-b {
    # add one to each item in the vertical line
    for $i-a ... $i-b -> $i {
      ++@ocean-floor-list[$i][$j-a]
    } 
  } elsif $i-a == $i-b {
    for $j-a ... $j-b -> $j {
      # add one to each item in the horizontal line
      ++@ocean-floor-list[$i-a][$j]
    }
  } else {
    die "unreachable"
  }
}

# print the amount of items that are greater than 1
say @ocean-floor-list>>.List.flat.grep({$^a > 1}).elems