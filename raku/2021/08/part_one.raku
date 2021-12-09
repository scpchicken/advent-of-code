use v6.d;

say lines.map({$^a.split(" | ")[1].words>>.chars.grep({$_ ~~ 2 | 3 | 4 | 7}).elems}).sum