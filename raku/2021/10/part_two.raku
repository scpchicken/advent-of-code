use v6.d;

my Str:D @line-arr = lines;

my Int:D @score-arr;
my %score-hash{Str:D} of UInt:D = ("(" => 1, "[" => 2, '{' => 3, "<" => 4);

for @line-arr -> $nav-str is copy {
  $nav-str ~~ s:g/"()"||"[]"||'{}'||"<>"// for ^69;
  my $corrupted = $nav-str.comb.first(-> $char {")]}>".contains($char)});

  without $corrupted {
    @score-arr.push([0, |$nav-str.flip.comb].reduce(-> $num, $char {
      $num * 5 + %score-hash{$char}
    }));
  }
}


say @score-arr.sort[@score-arr.elems / 2];