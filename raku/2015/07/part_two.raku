use v6.d;
use lib ".";
use Bruh;

my &get-wire-a = -> @connection-arr is copy {
  my Circuit-Action $circuit = Circuit-Action.new;

  while @connection-arr.elems {
    @connection-arr .= grep(-> $connection-str {
      Circuit-Grammar.parse($connection-str, actions => $circuit).made
    })
  }

  $circuit.wire-hash{"a"}
}


my regex wire-b {
  " -> b" $$
}

my @connection-arr = lines;

my $wire-a = @connection-arr.&get-wire-a;
@connection-arr[@connection-arr.first({/<wire-b>/}, :k)] = "$wire-a -> b";

say @connection-arr.&get-wire-a