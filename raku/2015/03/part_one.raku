use v6.d;

my Str:D @dir-arr = get.comb;

# say @dir-arr;

my UInt:D %dir-hash{Str:D};
my Int:D $curr-x = 0;
my Int:D $curr-y = 0;


for @dir-arr -> $dir {
  $curr-x += $dir eq "<" ?? -1 !! $dir eq ">" ?? 1 !! 0;
  $curr-y += $dir eq "^" ?? -1 !! $dir eq "v" ?? 1 !! 0;

  ++%dir-hash{"$curr-x $curr-y"}
}

say %dir-hash.keys.elems