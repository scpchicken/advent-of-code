use v6.d;
use lib ".";
use Bruh;

my Circuit-Action $circuit = Circuit-Action.new;

my @connection-arr = lines;

while @connection-arr.elems {
  @connection-arr .= grep(-> $connection-str {
    Circuit-Grammar.parse($connection-str, actions => $circuit).made
  })
}

say $circuit.wire-hash{"a"}