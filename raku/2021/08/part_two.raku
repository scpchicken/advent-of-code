use v6.d;

my Str:D @input-arr = lines;

my Int:D $total = 0;

# array to filter all the digits for permutation checking
my Str:D @segment-check-arr = <012456 25 02346 02356 1235 01356 013456 025 012356>;

for @input-arr -> Str:D $input {

  # store first part (signals) into array
  my Str:D @signal-wire-arr = $input.split(" | ")[0].words;

  # store last part (segments) into array
  my Str:D @segment-arr = $input.split(" | ")[1].words;

  # declare a segment hash that will hold maps of signal to num
  my %segment-hash{Str:D} of UInt:D;

  # iterate over all the permutations and store in array check
  <d e a f g b c>.permutations.first(-> @check {

    # iterate over segments and check if they have one mapping
    my @segment-correct-arr = @segment-check-arr.map(-> $segment {
      # keep only the indicies that are needed in that number
      my @bruh = @check[$segment.comb>>.Int];

      # iterate over signal wire array and save only the ones where the signal is the same as bruh
      @signal-wire-arr.grep({$^a.comb.Set === @bruh.Set})
    });

    # check if the segment correct array is correct and then add to segment hash the correct signal to num mappings
    if @segment-correct-arr.grep(*.elems) == 9 {
      for [0, 1, 2, 3, 4, 5, 6, 7, 9] Z @segment-correct-arr -> ($ind, @correct) {
        %segment-hash{@correct[0].comb.sort.join} = $ind
      }

      True
    } else {
      False
    }
  });

  # increment the total by the output values
  $total += @segment-arr.map(-> $seg {%segment-hash{$seg.comb.sort.join} // 8}).join.Int;
}

# print the total
say $total