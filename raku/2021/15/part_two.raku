use v6d;
use lib ".";
use Bruh;

my Array:D @grid = lines.map(-> $line {
  $line.comb>>.Int.Array
}).Array;

@grid = @grid.map(-> @line {
  [^5].map(-> $inc {
    |@line.map(-> $num is copy {
      $num += $inc;
      $num >= 10 ?? $num - 9 !! $num
    }).Array
  }).Array
}).Array;

@grid = [^5].map(-> $inc {
  @grid.map(-> @line {
    @line.map(-> $num is copy {
      $num += $inc;
      $num >= 10 ?? $num - 9 !! $num
    }).Array
  }).Array
}).List.flat.Array;

say @grid.&dijkstra