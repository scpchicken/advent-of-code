use v6.d;

# array to check segments are in the correct spot in permutation test
my @segment-check-arr = <abcefg cf acdeg acdfg bcdf abdfg abdefg acf abcdefg abcdfg>;

my &translate = -> @perm-arr, @segment-arr {
  # translate perm array to abcdefg
  my %trans-hash = (@perm-arr Z "abcdefg".comb).map(-> ($perm, $base) {$perm => $base}).List;

  # translate the array and map to joined string
  @segment-arr.trans(%trans-hash).words.map(-> $str {$str.comb.sort.join})
}

# function to check if 
my &test = -> @perm-arr, @signal-arr {
  @perm-arr.&translate(@signal-arr).all (elem) @segment-check-arr
}

# split each line into a signal and segment arrays
my Array:D @input-arr = lines.map(-> $line {
  $line.split(" | ").map({$^a.words}).Array
});

my Int:D $total = 0;

# get the digit hash as a key value pair of sorted string and the index
my %digits-hash{Str:D} of UInt:D = @segment-check-arr.kv.map(-> $ind, $segment {$segment.comb.sort.join => $ind});


# iterate over input arr
for @input-arr -> [@signal-arr, @segment-arr] {
  # declare a segment hash that will hold maps of signal to num
  my %segment-hash{Str:D} of UInt:D;
  for <a b c d e f g>.permutations -> @perm-arr {
    if @perm-arr.&test(@signal-arr) {
      $total += @perm-arr.&translate(@segment-arr).map(-> $str {%digits-hash{$str}}).join.Int;
      last
    }
  }
}

# print the total
say $total