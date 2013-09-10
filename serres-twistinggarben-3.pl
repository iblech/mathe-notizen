#!/usr/bin/perl
# splot "<perl serre.pl 1", "<perl serre.pl" w lp, "<perl serre.pl 1 20", "<perl serre.pl 0 100 -1" w lp, "<perl ./ingo-misc/Doktorarbeit/serres-twistinggarben.pl 300 0.1/\\\$y" w lp


use warnings;
use strict;

use constant PI => 4 * atan2(1,1);
use constant R1 => 10;
use constant R2 => 2;
use constant I  => 10;

# Nutze Iso S^1 --> P^1.

for(my $phi = 0; $phi < 2*PI; $phi += 2*PI/($ARGV[1] || 100)) {
  # Homogene Koordinaten entsprechend phi unter dem Iso.
  my $u = cos($phi / 2);
  my $v = sin($phi / 2);

  # Dreidimensionaler Vektor, dessen Spann geplottet werden soll.

  # für O(-1):
  #my $x = $u;
  #my $y =  0;
  #my $z = $v;

  # für O(-2):
  #my $x = $u**2;
  #my $y = $u*$v;
  #my $z = $v**2;

  # für O(-3):
  #my $x = $u**3;
  #my $y = $u * $v**2;
  #my $z = $v**3;  #$v**2 * $v;

  # für O(-4):
  my $x = $u**4;
  my $y = $u * $v**3;
  my $z = $v**2 * $v**2;

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
