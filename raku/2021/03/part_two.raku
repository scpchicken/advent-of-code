
use v6.d;

# store common, uncommon and binary list as input lines
my @common = my @uncommon = my @bin_list = lines;

# store current index at 0
my $ind = 0;

# loop while there is more than one element in common
while @common.elems > 1 {

  # get the count of 0 and 1 at index
  my %count =  @common.map({$^a.comb[$ind].Int}).Bag.Hash;

  # set the 0 if there isn't anything there
  %count<0> max= 0;
  %count<1> max= 1;

  # get the most common bit or 1 if they are same
  my $common_bit = %count<1> >= %count<0> ?? 1 !! 0;

  # filter all the ones that have the common bit at that index
  @common = @common.grep({$^a.comb[$ind] eq $common_bit});

  # increment index
  ++$ind;
}

# store current index at 0 again
$ind = 0;

# same
while @uncommon.elems > 1 {
  my %count = @uncommon.map({$^a.comb[$ind].Int}).Bag.Hash;

  %count<0> max= 0;
  %count<1> max= 1;

  # get the least common bit or 0 if they are same
  my $uncommon_bit = %count<0> <= %count<1> ?? 0 !! 1;

  @uncommon = @uncommon.grep({$^a.comb[$ind] eq $uncommon_bit}); 
  $ind++;
}

# print the product of the only element of common and only element of uncommon after converting base 2 to base 10
say @common[0].parse-base(2) * @uncommon[0].parse-base(2)