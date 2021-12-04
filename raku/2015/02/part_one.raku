use v6.d;

# pointy block anonymous function that takes 3 numbers in a list and return the amount of wrapping paper needed to wrap a present
my &wrapping = -> [\a, \b, \c] {2 * (a * b + b * c + c * a) + [a * b, b * c, c * a].min};

# map the on splitting of "x" and map those to integer and pass to &wrapping the get the sum
say lines.map(*.List.split("x")>>.Int.&wrapping).sum