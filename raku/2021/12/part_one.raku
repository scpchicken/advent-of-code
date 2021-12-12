use v6.d;

my %neighbour-hash{Str:D} of Array:D;

lines.map(-> $line {
  my ($start, $end) = $line.split("-");
  %neighbour-hash{$start}.push($end);
  %neighbour-hash{$end}.push($start);
});

say %neighbour-hash.&path-count("start", SetHash.new);


sub path-count(%neighbour-hash, Str:D $cave, SetHash:D $small-cave-set --> UInt:D) { 

  # valid path
  return 1 if $cave eq "end";

  # add to set all the ones that don't contain uppercase
  if $cave ~~ /<[a..z]>/ {
    $small-cave-set.set($cave)
  }

  %neighbour-hash{$cave}.Array.map(-> $neighbour {

    # check if neighbour is already in the set
    if !$small-cave-set{$neighbour} {

      # continue the path with the neighbour
      path-count(%neighbour-hash, $neighbour, $small-cave-set.clone)
    }

  # get the sum
  }).sum
}
