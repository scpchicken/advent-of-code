use v6.d;

my $template-str = get;
get;

my %pair-lookup-hash = lines.map(-> $pair-str {
  my ($k, $v) = $pair-str.split(" -> ");
  $k => $v
}).List;


for ^10 {
  my @template-new-arr;

  for ($template-str ~ "🦋").comb.rotor(2 => -1) -> ($a, $b) {
    if %pair-lookup-hash{"$a$b"}:exists {
      @template-new-arr.push([$a, %pair-lookup-hash{"$a$b"}])
    } else {
      @template-new-arr.push([$a]);
    }
  }


  $template-str = @template-new-arr>>.List.flat.join;
}

my @element-count = $template-str.comb.Bag.kv.map(-> $element, $amount {$amount});


say @element-count.max - @element-count.min;