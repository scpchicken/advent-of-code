use v6d;
unit module Bruh;

class PriorityQueue is export {
  has %!queue;
  has $!count = 0;

  method is-empty {
    %!queue.elems == 0
  }

  method insert(:$cost, :$i, :$j) {
    %!queue{$!count++} = {
      cost => $cost,
      i => $i,
      j => $j,
    }
  }

  method get-cheapest {
    my $smol-pp = %!queue.min(-> $elem {$elem.value<cost>});
    %!queue{$smol-pp.key}:delete
  }
}

sub dijkstra(Array:D @grid) is export {
  my SetHash:D $visited = SetHash.new;
  my %cost-hash{Str:D} of UInt:D;

  my UInt:D $width = @grid[0].elems;
  my UInt:D $height = @grid.elems;

  my UInt:D $end-i = $height.pred;
  my UInt:D $end-j = $width.pred; 

  my PriorityQueue $heap-q = PriorityQueue.new;

  $heap-q.insert(cost => 0, i => 0, j => 0);

  until $heap-q.is-empty {
    my %hash = $heap-q.get-cheapest.List;
    my (UInt:D $cost, UInt:D $i, UInt:D $j) = <cost i j>.map(-> $key {%hash{$key}});


    if "$i $j" (elem) $visited {
      next
    }

    $visited.set("$i $j");
    %cost-hash{"$i $j"} = $cost;

    if ($i, $j) eqv ($end-i, $end-j) {
      last
    }

    for [[$i, $j.succ], [$i, $j.pred], [$i.succ, $j], [$i.pred, $j]].grep(-> (Int:D $new-i, Int:D $new-j) {
      0 <= $new-i <= $end-i && 0 <= $new-j <= $end-j
    }) -> ($new-i, $new-j) {
      $heap-q.insert(cost => $cost + @grid[$new-i][$new-j], i => $new-i, j => $new-j)
    }
  }

  %cost-hash{"{$height.pred} {$width.pred}"}
}