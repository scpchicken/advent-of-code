use v6.d;

my (Int:D $start-j, Int:D $end-j, Int:D $start-i, Int:D $end-i) = ((get) ~~ m:g/"-"?\d+/)>>.Int;

my Int:D $max-i = -696969;
my Int:D $max-height = 69;

for 0 .. $end-j -> Int:D $vj {
  for $start-i .. $end-j -> Int:D $vi { 
    my Int:D $vel-i = $vi;
    my Int:D $vel-j = $vj;
    my Int:D $i = 0;
    my Int:D $j = 0;
    my Int:D $max-curr-height = -696969;

    while $j < $end-j && $i > $end-i {
      $i += $vel-i;
      $j += $vel-j;

      $max-curr-height = [$max-curr-height, $i].max;

      $vel-j = [$vel-j - 1, 0].max;
      $vel-i .= pred;

      if $start-i <= $i <= $end-i && $start-j <= $j <= $end-j && $vi > $max-i {
        $max-height = $max-curr-height;
        $max-i = $vi;
      }
    }
  }
}

say $max-height;