#!/usr/bin/perl

use warnings;
use strict;

use constant PI => 4 * atan2(1,1);
use constant R1 => 10;
use constant R2 => 2;
use constant I  => 10;

my $a = $ARGV[0] || 100;
my $f = $ARGV[1];
die unless defined $f;

my $g = eval "sub { my (\$x, \$y) = \@_; return($f) }";
die $@ if $@;

my $n = sprintf "%.0f", -log($g->(10, 100) / $g->(1, 10)) / log(10);
warn "Grad: -$n\n";
die unless $n == 1;

#for(1..100) {
#  # [1:0]
#  printf "%f\t%f\t%f\n", R1 * cos(0) + rand, R1 * sin(0) + rand, rand;
#}
#
#for(1..10) {
#  # quasi [1:0.1]
#  printf "%f\t%f\t%f\n", R1 * cos(0.3) + rand, R1 * sin(0.3) + rand, rand;
#}

for(my $phi = 0; $phi < 2*PI; $phi += 2*PI/$a) {
  my $x = 1;
  my $y = sin($phi/2) / cos($phi/2);
  my $l = eval { $g->($x, $y) };
  next unless defined $l;

  my $plotx = R1 * cos($phi);
  my $ploty = R1 * sin($phi);

  my $u = cos($phi / 2);
  my $v = sin($phi / 2);

  #for(my $t = 0; $t < I; $t++) {
    my $t = I;
    printf "%f\t%f\t%f\n",
        $plotx + $t/I * $l * $u * R2 * (-cos($phi)),
        $ploty + $t/I * $l * $u * R2 * (-sin($phi)),
        $t/I * $l * $v * R2;
  #}
}
