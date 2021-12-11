use v6.d;

my &flash = -> Array:D @octopus-arr, UInt:D $ind, UInt:D $jnd {
  for $ind - 1 .. $ind + 1 -> Int:D $i {
    for $jnd - 1 .. $jnd + 1 -> Int:D $j {
      if 0 <= $i < @octopus-arr.elems && 0 <= $j < @octopus-arr[0].elems {
        @octopus-arr[$i][$j] += 1
      }
    }
  }
}


my Array:D @octopus-arr = lines.map(-> $line {$line.comb.Array>>.Int});
my UInt:D $total = 0;

for ^100 {
  my %flash-hash{Str:D} of UInt:D;

  @octopus-arr = @octopus-arr.map(-> @line {
    @line.map(-> UInt:D $num {
      $num + 1
    }).Array
  });

  for ^69 {
    for @octopus-arr.kv -> UInt:D $ind, @line {
      for @line.kv -> UInt:D $jnd, UInt:D $num {
        if $num >= 10 && (%flash-hash{"$ind $jnd"}:!exists) {
          @octopus-arr.&flash($ind, $jnd);
          %flash-hash{"$ind $jnd"} = 69;
        }
      }
    }
  }


  $total += @octopus-arr>>.List.flat.grep(-> UInt:D $num {$num >= 10}).elems;
  @octopus-arr = @octopus-arr.map(-> @line {
    @line.map(-> UInt:D $num {
      $num >= 10 ?? 0 !! $num
    }).Array
  });
}

say $total