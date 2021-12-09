use v6.d;

# get the heat map as 2d array of digits
my Array:D @heat-map = lines.map(-> $line {$line.comb>>.Int.Array});

# map over index and line of heat map
say @heat-map.kv.map(-> Int:D $ind, @line {
  # filter out all items in the line that are not the low point
  @line.kv.grep(-> Int:D $jnd, Int:D $num {

    # check all adjacemnt sides for to see if it's a low point
    [($ind - 1, $jnd), ($ind + 1, $jnd), ($ind, $jnd - 1), ($ind, $jnd + 1)].grep(-> ($i, $j) {
      $i >= 0 && $i < @heat-map.elems && $j >= 0 && $j < @heat-map[0].elems
    }).map(-> (Int:D $i, Int:D $j) {
      @heat-map[$i][$j] > $num 
    }).all == True
  
  # keep only num + 1
  }).map(-> (Int:D $jnd, Int:D $num) {
    $num + 1
  }).sum
}).sum