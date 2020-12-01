use List::Util qw[max sum];

sub paper_required {
	my ($a, $b, $c) = @_;
	my $needed = 2 * ($a*$b + $b*$c + $a*$c);

	if (max(($a,$b,$c)) == $a) {
		$needed += $b*$c;
	}
	elsif (max(($a,$b,$c)) == $b) {
		$needed += $a*$c;
	}
	else {
		$needed += $a*$b;
	}
	return $needed;
}
while (<>) {
	chomp;
        ($a, $b, $c) = split /x/;
	$n += paper_required($a, $b, $c);
}

print "total needed at end is $n\n";
