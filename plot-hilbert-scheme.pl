#!/usr/bin/perl

use warnings;
use strict;

use constant MAX => $ARGV[0] || 5;
use constant DT  => $ARGV[1] || 0.1;

for(my $a0 = -MAX; $a0 < MAX; $a0 += DT) {
for(my $a1 = -MAX; $a1 < MAX; $a1 += DT) {
  next unless $a1**2 - 4*$a0 >= 0;
  for my $x (
    (-$a1 - sqrt($a1**2 - 4*$a0)) / 2,
    (-$a1 + sqrt($a1**2 - 4*$a0)) / 2,
  ) {
    printf "%f\t%f\t%f\n", $a0, $a1, $x;
  }
}}
