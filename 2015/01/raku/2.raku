use v6.d;

my @instruction-list = @*ARGS[0].comb.map(* eq "(" ?? 1 !! -1);

say +[[\+] @instruction-list ... -1];