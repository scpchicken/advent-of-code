use v6.d;

# anonymous point block function to get all the points in the basin
my &get-basin = -> Array:D @heat-map, Int:D $ind, Int:D $jnd, @basin-arr {
  if @heat-map[$ind][$jnd] != 9 {
    @basin-arr.push([$ind, $jnd]); 
    
    # iterate over neighbours and check if any of them have any neighbours that are within the basin and add the mto the basin array
    for [[$ind + 1, $jnd], [$ind - 1, $jnd], [$ind, $jnd + 1], [$ind, $jnd - 1]] -> [$i, $j] {
      if $i >= 0 && $i < @heat-map.elems && $j >= 0 && $j < @heat-map[0].elems && !(@basin-arr.any eqv [$i, $j]) {
        @basin-arr = @heat-map.&get-basin($i, $j, @basin-arr);
      }
    }
  }

  # return the basin array for recursion and for the final result
  @basin-arr
}

# get the heat map as 2d array of digits
my Array:D @heat-map = lines.map(-> $line {$line.comb>>.Int.Array});

# get the low points the in theat map
my @low-ind-arr =  @heat-map.kv.map(-> Int:D $ind, @line {
  @line.kv.map(-> Int:D $jnd, Int:D $num {

    # check the adjacent heights to see if it is a low point and return index and jndex if so
    if [($ind - 1, $jnd), ($ind + 1, $jnd), ($ind, $jnd - 1), ($ind, $jnd + 1)].grep(-> ($i, $j) {
      $i >= 0 && $i < @heat-map.elems && $j >= 0 && $j < @heat-map[0].elems
    }).map(-> (Int:D $i, Int:D $j) {
      @heat-map[$i][$j] > $num 
    }).all == True {
      [$ind, $jnd]
    } else {
      []
    }
  })
})>>.Array.flat.grep(-> @arr {@arr.elems});

# map over low ind array and get the basin for each point
# get the size of each
# sort it and get the last 3 elements
# print the product
say [*] @low-ind-arr.map(-> [Int:D $i, Int:D $j] {@heat-map.&get-basin($i, $j, [])}).map(-> @arr {@arr.elems}).sort.tail(3)