use strict;
use warnings;
use feature 'say';

sub is_palindrome {
    my ($number) = @_;
    my $string_number = "$number";
    return $string_number eq reverse $string_number;
}

my $current_max = 0;

for my $i (100 .. 999) {
    for my $j (100 .. 999) {
        my $product = $i * $j;
        if ($product > $current_max && is_palindrome($product)) {
            $current_max = $product;
        }
    }
}

say $current_max;
