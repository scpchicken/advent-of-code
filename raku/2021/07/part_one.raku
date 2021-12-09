use v6.d;

my Int @pos-arr = get.split(",")>>.Int.List;


my Int @fuel-arr;

for ^2000 -> $check-pos {
  @fuel-arr.push(@pos-arr.map(-> $pos {($check-pos - $pos).abs}).sum);
}

say @fuel-arr.min;