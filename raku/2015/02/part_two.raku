use v6.d;

# point block anonymous function ribbon
# takes 3 arguments
# sort those 3 elements
# grab the smallest 2
# add the together
# multiply it by 2
# get the prodct of the 3 numbers
# add them together
my &ribbon = -> [\a, \b, \c] {([+] [a, b, c].sort.head(2)) * 2 + [*] [a, b, c]}

# map the lines
# on splitting on "x"
# map each of those strings to int
# call &ribbon on the 3 numbers
# get the total sum
say lines.map(*.List.split("x")>>.Int.&ribbon).sum