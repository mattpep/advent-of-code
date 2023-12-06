#!/usr/bin/env perl

use strict;
use warnings;

sub count_wins {
  my $wins = 0;
  my $time = shift;
  my $win_distance = shift;

  my @times = (1..$time);
  for (@times) {
    my $holding = $_;
    my $moving = $time - $holding;

    my $distance = $holding * $moving;
    if ($distance > $win_distance) {
      $wins++;
    }
  }
  return $wins;
}

my $line;

$line = <>;
$line =~ s/Time://;
my @times = split(" ", $line);

$line = <>;
$line =~ s/Distance://;
my @distances = split(" ", $line);

my $score = 1;
my @races = 0 .. $#times ;
for (@races) {
  # print ("starting race number: $_\n");
  # print("  the two parts are: >$times[$_]< and >$distances[$_]<\n");
  my $win_count = count_wins($times[$_], $distances[$_]);
  # print "Win count for race $_: $win_count\n";
  $score *= $win_count;
}

print "Part 1: $score\n";

my $distance = join('', @distances);
my $time = join('', @times);
exit;
$score = 1;
my $win_count = count_wins($time, $distance);
print "Win count for race $_: $win_count\n";
$score *= $win_count;
print "Part 2: $score\n";
