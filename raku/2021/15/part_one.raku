use v6d;
use lib ".";
use Bruh;

my Array:D @grid = lines.map(-> $line {
  $line.comb>>.Int.Array
}).Array;


say @grid.&dijkstra