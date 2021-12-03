use v6.d;

# strings to store numbers
my $common_str = my $uncommon_str = "";

# store lines in bary list
my @bin_list = lines;

# count from 0 to 11 as ind variable
for ^12 -> $ind {
  # get the count of 0 and 1 at that index
  my %count =  @bin_list.map({$^a.comb[$ind]}).Bag;

  # string append the most common bit or 1 if the are same the common
  $common_str ~= %count<1> >= %count<0> ?? 1 !! 0;

  # string append the least common bit or 0 if they are same to uncommon
  $uncommon_str ~= %count<0> <= %count<1> ?? 0 !! 1;

}

# multiple the strings after parsing each from base 2 to base 10
say $uncommon_str.parse-base(2) * $common_str.parse-base(2)