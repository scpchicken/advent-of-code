use v6.d;

my Str:D @str-arr = lines;

say @str-arr.grep(-> Str:D $str {
  $str ~~ /(..) .*? $0/ && $str ~~ /(.) . $0/
}).elems