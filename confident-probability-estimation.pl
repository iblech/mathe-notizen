#!/usr/bin/perl

use warnings;
use strict;

use List::Util qw< sum >;

use constant BATCHSIZE => 10000;

sub pdf_supernaive {
    my ($eps, $alpha, $warmup, $X) = @_;

    my $n = 0;
    my %seen;

    until($n >= $warmup and $n >= (my $bound = keys(%seen) / (4 * $alpha * $eps**2))) {
        $seen{$X->()}++ for 1..BATCHSIZE;
        $n += BATCHSIZE;

        print STDERR "$n\t$bound\n" if $n % 100000 == 0;
    }
    print STDERR "$n\n";

    $seen{$_} /= $n for keys %seen;

    return \%seen;
}

sub pdf_naive {
    my ($eps, $alpha, $warmup, $X) = @_;

    my $n = 0;
    my %seen;

    until($n >= $warmup and $n >= (my $bound = sum(map { $_ * ($n-$_) / $n**2 } values(%seen)) / ($alpha * $eps**2))) {
        $seen{$X->()}++ for 1..BATCHSIZE;
        $n += BATCHSIZE;

        print STDERR "$n\t$bound\n" if $n % 100000 == 0;
    }
    print STDERR "$n\n";

    $seen{$_} /= $n for keys %seen;

    return \%seen;
}

sub X {
    my $steps = 0;
    my %numbers;
    until(keys %numbers == 6) {
        $numbers{int rand 6}++;
        $steps++;
    }
    return $steps;
}

use constant EPS    => $ARGV[0] || 0.01;
use constant ALPHA  => $ARGV[1] || 0.05;
use constant WARMUP => 50;

my %seen = %{ pdf_naive(EPS, ALPHA, WARMUP, \&X) };
for my $k (sort { $a <=> $b } keys %seen) {
    printf "%d\t%f\n", $k, $seen{$k};
}

%seen = %{ pdf_supernaive(EPS, ALPHA, WARMUP, \&X) };
for my $k (sort { $a <=> $b } keys %seen) {
    printf "%d\t%f\n", $k, $seen{$k};
}
