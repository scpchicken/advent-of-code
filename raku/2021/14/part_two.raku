use v6.d;


my $template-str = get;
get;

my %pair-lookup-hash = lines.map(-> $pair-str {
  my ($k, $v) = $pair-str.split(" -> ");
  $k => $v
}).List;


my &pair-bag-get = -> Str:D $str --> BagHash:D {
  $str.comb.rotor(2 => -1)>>.join.BagHash
}

my %pair-bag{Str:D} of UInt:D = $template-str.&pair-bag-get; 

for ^40 {
  my %pair-new-bag{Str:D} of UInt:D;

  for %pair-bag.kv -> $pair-str, $pair-count {
    my ($elem-a, $elem-b) = $pair-str.comb;

    for ($elem-a ~ (%pair-lookup-hash{$elem-a ~ $elem-b} // "") ~ $elem-b).&pair-bag-get.kv -> $ps, $pc {
      %pair-new-bag{$ps} += $pc * $pair-count
    }
  }

  %pair-bag = %pair-new-bag.clone;
}


my %element-bag{Str:D} of UInt:D;

for %pair-bag.kv -> $pair-str, $pair-count {
  %element-bag{$pair-str.comb[0]} += $pair-count
}

%element-bag{$template-str.comb[* - 1]} .= succ;

my @element-count-arr = %element-bag.values;

say @element-count-arr.max - @element-count-arr.min