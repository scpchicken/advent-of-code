use v6.d;

# group input as repeated slicing of 2 forward, going back once each iteration
# flatten the list
# get amount of times the second number is numerically greater than the first
say lines.rotor(2 => -1).flat.map({$^b > $^a}).sum