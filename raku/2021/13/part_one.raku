use v6.d;
use lib ".";
use Bruh;

my (Str:D $dot-str, Str:D $fold-str) = slurp.split("\n\n");

my Array:D @dot-arr = $dot-str.lines.map(-> Str:D $coord-str {
  $coord-str.split(",")>>.Int.Array
});

my Array:D @fold-arr = $fold-str.chomp.lines.map(-> Str:D $fold {
  $fold ~~ /(.) "=" (\d+)/;
  [$0.Str, $1.Int]
});

my UInt:D $grid-size-i = @dot-arr.map(-> [$x, $y] {$y}).max.succ;
my UInt:D $grid-size-j = @dot-arr.map(-> [$x, $y] {$x}).max.succ;

my Array:D @paper-grid = ("." xx $grid-size-j xx $grid-size-i)>>.Array;

for @dot-arr -> (UInt:D $j, UInt:D $i) {
  @paper-grid[$i][$j] = "#";
}

my (Str:D $fold-dir, UInt:D $fold-pos) = @fold-arr[0];

say @paper-grid.&fold-paper($fold-dir, $fold-pos, $grid-size-i, $grid-size-j).comb("#").elems
