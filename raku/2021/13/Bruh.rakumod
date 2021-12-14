use v6.d;
unit module Bruh;

sub fold-paper(Array:D @paper-grid, Str:D $fold-dir, UInt:D $fold-pos, UInt:D $grid-size-i, UInt:D $grid-size-j --> Array:D) is export {
  my Array:D @paper-new-grid;

  given $fold-dir {
    when "x" {
      @paper-new-grid = @paper-grid.map(-> @arr {@arr[^$fold-pos].Array});

      for ^$grid-size-i -> UInt:D $i {
        for $fold-pos + 1 .. $grid-size-j - 1 -> UInt:D $j {
          if @paper-grid[$i][$j] eq "#" {
            @paper-new-grid[$i][$fold-pos * 2 - $j] = "#"
          }
        }
      }
    }

    when "y" {
      @paper-new-grid = @paper-grid[^$fold-pos]>>.Array;

      for $fold-pos + 1 .. $grid-size-i - 1 -> UInt:D $i {
        for ^$grid-size-j -> UInt:D $j {
          if @paper-grid[$i][$j] eq "#" {
            @paper-new-grid[$fold-pos * 2 - $i][$j] = "#"
          }
        }
      }
    }

    default {
      die "not x or y"
    }
  }

  @paper-new-grid
}