my ($a, $b) = (0, 1);
my $sum = 0;

while (1) {
    my $next = $a + $b;
    last if $next >= 4_000_000;

    $sum += $next if $next % 2 == 0;

    ($a, $b) = ($b, $next);
}

print "$sum\n";
