use v6.d;

my Int @pos-arr = get.split(",")>>.Int.List;


my Int @fuel-arr;

for ^1500 -> $check-pos {
  @fuel-arr.push(@pos-arr.map(-> $pos {
    [1..($check-pos - $pos).abs].sum
  }).sum);
}

say @fuel-arr.min;