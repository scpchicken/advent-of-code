use v6.d;

my %neighbour-hash{Str:D};

lines.map(-> $line {
  my ($start, $end) = $line.split("-");
  %neighbour-hash{$start}.push($end);
  %neighbour-hash{$end}.push($start);
});

my Array:D @path-arr = [["start"],];
my Array:D @path-valid-arr = [];

# make sure you iterate over all paths
while @path-arr.elems != 0 {
  my Str:D @path-curr = @path-arr.pop.flat;

  # check if the path ends in "end" and add it to a valid path
  if @path-curr[*-1] eq "end" {
    @path-valid-arr.push(@path-curr);
    next
  }
  
  # get the amount of non uppercase in 
  my %counter = @path-curr.grep({$^a eq $^a.lc}).Bag;

  # skip the iteration if there is a lowercase duplicate
  if (%counter{"start"} // 0) > 1 || (%counter{"end"} // 0) > 1 || %counter.keys.grep({%counter{$^a} > 1}).elems > 1 || %counter.keys.map({%counter{$^a} > 2}).any {
    next
  }

  # add another path the check based on the last cave in current path
  for %neighbour-hash{@path-curr[*-1]}.Array -> $neighbour {
    @path-arr.push([|@path-curr, $neighbour])
  }
}

say @path-valid-arr.elems;