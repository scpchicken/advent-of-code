use v6.d;

my Str:D @str-arr = lines;
my Str:D @bad-str-arr = <ab cd pq xy>;

say @str-arr.grep(-> Str:D $str {
  $str ~~ /(.) $0/ && $str ~~ m:g/<[aeiou]>/ >= 3 && @bad-str-arr.map(-> Str:D $bad-str {$str !~~ /$bad-str/}).all
}).elems