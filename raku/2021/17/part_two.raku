use v6.d;

my (Int:D $start-j, Int:D $end-j, Int:D $start-i, Int:D $end-i) = ((get) ~~ m:g/"-"?\d+/)>>.Int;

my UInt:D $total = 0;
  
for 0 .. $end-j -> Int:D $vj {
  for $start-i .. $end-j -> Int:D $vi { 
    my Int:D $vel-i = $vi;
    my Int:D $vel-j = $vj;
    my Int:D $i = 0;
    my Int:D $j = 0;

    while $j < $end-j && $i > $start-i {
      $i += $vel-i;
      $j += $vel-j;
      $vel-j = [$vel-j - 1, 0].max;
      $vel-i .= pred;

      if $start-i <= $i <= $end-i && $start-j <= $j <= $end-j {
        $total .= succ;
        last
      }
    }
  }
}

say $total