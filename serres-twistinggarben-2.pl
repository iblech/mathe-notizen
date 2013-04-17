#!/usr/bin/perl
# splot "<perl serre.pl 1", "<perl serre.pl" w lp, "<perl serre.pl 1 20", "<perl serre.pl 0 100 -1" w lp, "<perl ./ingo-misc/Doktorarbeit/serres-twistinggarben.pl 300 0.1/\\\$y" w lp


use warnings;
use strict;

use constant PI => 4 * atan2(1,1);
use constant R1 => 10;
use constant R2 => 2;
use constant I  => 10;

for(my $phi = 0; $phi < 2*PI; $phi += 2*PI/($ARGV[1] || 100)) {
  my $u = cos($phi / 2);
  my $v = sin($phi / 2);

  my $plotx = R1 * cos($phi);
  my $ploty = R1 * sin($phi);

  my ($a,$b,$c) = ($u,$u,$v);

  if($ARGV[0]) {
    for(my $t = -I(); $t < I; $t++) {
      printf "%f\t%f\t%f\n",
          $plotx + $t/I * $a * R2 * (-cos($phi)),
          $ploty + $t/I * $b * R2 * (-sin($phi)),
          $t/I * $c * R2;
    }
  } else {
      my $t = I;
      my $p = $ARGV[2] || 1;
      printf "%f\t%f\t%f\n",
          $plotx + $p * $t/I * $a * R2 * (-cos($phi)),
          $ploty + $p * $t/I * $b * R2 * (-sin($phi)),
          $t/I * $p * $c * R2;
  }
}
