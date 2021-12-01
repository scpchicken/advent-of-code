use v6.d;

# group input as repeated slicing of 3 forward, going back twice each iteration
# map sum over all of those slices
# rest is same as part 1
say lines.rotor(3 => -2)>>.sum.rotor(2 => -1).flat.map({$^b > $^a}).sum