#!/usr/bin/perl
# splot "<perl serre.pl 1", "<perl serre.pl" w lp, "<perl serre.pl 1 20", "<perl serre.pl 0 100 -1" w lp, "<perl ./ingo-misc/Doktorarbeit/serres-twistinggarben.pl 300 0.1/\\\$y" w lp


use warnings;
use strict;

use constant PI => 4 * atan2(1,1);
use constant R1 => 10;
use constant R2 => 2;
use constant I  => 10;

# Nutze Iso S^1 --> P^1.

my $n = $ARGV[0] || (-1);

for(my $phi = 0; $phi < 2*PI; $phi += 2*PI/($ARGV[1] || 100)) {
  # Homogene Koordinaten entsprechend phi unter dem Iso.
  my $u = cos($phi / 2);
  my $v = sin($phi / 2);

  # Dreidimensionaler Vektor, dessen Spann geplottet werden soll.
  # für O(n):
  my ($x,$y,$z);
  if($n < 0) {
    $x = $u**(-$n);
    $y = 0;
    $z = $v**(-$n);
  } else {
    $x = $v**$n;
    $y = 0;
    $z = $u**$n;
    die "Unsinn. Das geplottete Bündel ist algebraisch isomorph zu O(-$n).";
  }

  # Faserkoordinatensystem
  my $originx = R1 * cos($phi);
  my $originy = R1 * sin($phi);

  for(my $t = -I(); $t < I; $t < I-1 ? ($t++) : ($t += 0.1)) {
    printf "%f\t%f\t%f\n",
        $originx + $t/I * R2 * $x,
        $originy + $t/I * R2 * $y,
        0        + $t/I * R2 * $z;
  }
  print "\n";
}
