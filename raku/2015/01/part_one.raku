use v6.d;

# map ( to 1 and ) to -1 then get the sum
say get.comb.map({$^a eq "(" ?? 1 !! -1}).sum