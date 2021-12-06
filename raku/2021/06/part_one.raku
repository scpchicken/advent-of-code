use v6.d;

# get the fish in an array
my Int:D @fish-arr = get.split(",")>>.Int;
my Int:D @baby-arr = [];

# iterate over 80 days and check if they are 0 and then set them to 6 unless they are a baby fish
for ^80 {

  # update all fish breeding times and add the baby-arr if they can breed
  @fish-arr .= map(-> UInt:D $fish {
    if $fish == 0 {
      @baby-arr.push(9);
      6
    } else {
      $fish - 1
    }
  });

  # decrement all baby ages
  @baby-arr = @baby-arr.map(-> UInt:D $baby {
    $baby - 1
  
  # filter out all adults and then add another baby if they can breed
  }).grep(-> Int:D $baby {
    if $baby < 0 {
      @fish-arr.push(6);
      @baby-arr.push(9);
      False
    } else {
      True
    }
  });
}

# print the total fish
say @fish-arr.elems + @baby-arr.elems