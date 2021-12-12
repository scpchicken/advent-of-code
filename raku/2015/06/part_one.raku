use v6.d;

my &range-map = -> Array:D @arr, &func, UInt:D $start-i, UInt:D $start-j, UInt:D $end-i, UInt:D $end-j {
  for $start-i .. $end-i -> $i {
    for $start-j .. $end-j -> $j {
      @arr[$i][$j] .= &func
    }
  };

  @arr
};


my Array:D @arr = (0 xx 1000 xx 1000)>>.Array;

lines.map(-> Str:D $str {
  my (UInt:D $start-i, UInt:D $start-j, UInt:D $end-i, UInt:D $end-j) = ($str ~~ /(\d+)\,(\d+) .*? (\d+)\,(\d+)/).Array>>.Int;

  @arr = @arr.&range-map((given $str {
    when /"turn on"/ {
      -> UInt:D $light {1}
    }

    when /"turn off"/ {
      -> UInt:D $light {0}
    }

    when /"toggle"/ {
      -> UInt:D $light {$light +^ 1}
    }

    default {
      die "not any bruh"
    }
  }), $start-i, $start-j, $end-i, $end-j)
});

say @arr>>.List.flat.grep({$^a == 1}).elems