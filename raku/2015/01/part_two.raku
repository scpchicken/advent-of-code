use v6.d;

# get instruction list as a list of maaping ( to 1 and ) to -1 
my @instruction-list = get.comb.map({$^a eq "(" ?? 1 !! -1});

# triangular reduce the list until reaching -1 then get the length
say +[([\+] @instruction-list) ... -1];