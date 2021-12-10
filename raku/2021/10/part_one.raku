use v6.d;

my Str:D @line-arr = lines;

my %hash{Str:D} of UInt:D = (")" => 3, "]" => 57, "}" => 1197, ">" => 25137);

say @line-arr.map(-> Str:D $nav-str is copy {
  $nav-str ~~ s:g/"()"||"[]"||'{}'||"<>"// for ^69;
  my Str $corrupted = $nav-str.comb.first({")]}>".contains($^a)});

  with $corrupted {
    %hash{$corrupted}
  } else {
    0
  }
}).sum
