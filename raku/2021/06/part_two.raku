use v6.d;

# get the fish in an array
my %fish-hash{UInt:D} of Int:D = get.split(",")>>.Int.Bag;

# make a fish hash containing all breeding times or 0 if there are no fish there
my Int:D @fish-arr = (^8).map(-> $breed-time {
  %fish-hash{$breed-time} // 0
});


# make baby fish arr full of zeros
my Int @baby-arr = 0 xx 10;

# iterate from 0 to 256
for ^256 {
  @fish-arr[7] += @fish-arr[0] + @baby-arr[0];
  @baby-arr[9] += @baby-arr[0] + @fish-arr[0];
  @baby-arr[0] = 0;
  @fish-arr[0] = 0;

  @fish-arr = @fish-arr.rotate(1);
  @baby-arr = @baby-arr.rotate(1);
}

# get the total number of fish
say @fish-arr.sum + @baby-arr.sum;