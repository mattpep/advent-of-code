use strict;
use List::Util qw[max sum];

sub paper_required {
	my ($x, $y, $z) = @_;
	my @lengths = sort { $a <=> $b } ($x, $y, $z);

	my $needed = 2 * ($x*$y + $y*$z + $x*$z);

	$needed += $lengths[0] * $lengths[1];
	return $needed;
}

my $paper = 0;
while (<>) {
	chomp;
        my ($a, $b, $c) = split /x/;
	$paper += paper_required($a, $b, $c);
}

print "total paper needed at end is $paper\n";
