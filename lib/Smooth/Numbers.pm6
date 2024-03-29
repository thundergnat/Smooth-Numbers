unit module Smooth::Numbers:ver<0.0.3>:auth<zef:thundergnat>;

sub smooth-numbers (*@list where @list.all >= 1 ) is export {
    fail "Need to supply at least one factor to routine" unless @list.elems > 0;
    my \Smooth := gather {
        my %i = (flat @list) Z=> (Smooth.iterator for ^@list);
        my %n = (flat @list) Z=> 1 xx *;

        loop {
            take my $n := %n{*}.min;
            -> \k { %n{k} = %i{k}.pull-one * k if %n{k} == $n } for @list;
        }
    }
}

=begin pod

=head1 NAME
Smooth::Numbers

Given a list of prime factors, return an iterator which will produce numbers
that are "smooth" to those factors.


=head1 SYNOPSIS

=begin code :lang<raku>

use Smooth::Numbers;

my $Hammings = smooth-numbers(2,3,5);

put $Hammings[^20]; # 1 2 3 4 5 6 8 9 10 12 15 16 18 20 24 25 27 30 32 36

=end code

=head1 DESCRIPTION

Smooth numbers are defined as "numbers that are products of small prime
factors."

Hamming numbers, which are the numbers that are products of 2, 3, 5, is the
classic example.

The first ten Hamming numbers ( 2,3,5 smooth numbers ) are:

=begin code :lang<raku>

1  ( 2⁰ * 3⁰ * 5⁰ )
2  ( 2¹ * 3⁰ * 5⁰ )
3  ( 2⁰ * 3¹ * 5⁰ )
4  ( 2² * 3⁰ * 5⁰ )
5  ( 2⁰ * 3⁰ * 5¹ )
6  ( 2¹ * 3¹ * 5⁰ )
8  ( 2³ * 3⁰ * 5⁰ )
9  ( 2⁰ * 3² * 5⁰ )
10 ( 2¹ * 3⁰ * 5¹ )
12 ( 2² * 3¹ * 5⁰ )

=end code

Smooth numbers are easy to conceptualize but can be challenging to generate in
order. This module provides a simple routine to overcome that.

Exports a single subroutine:

=begin code :lang<raku>

sub smooth-numbers(*@factors)

=end code

Takes a list or array of factors and returns an iterator that generates an
ordered sequence of numbers that are smooth to those factors.

The factors need not be in any order, and need not be prime. Smooth numbers
traditionally are thought of as products of only prime factors, but if you want,
for instance, the products of powers of 4 and 9, this module will oblige.

=begin code :lang<raku>

put smooth-numbers(4,9)[^15];

# 1 4 9 16 36 64 81 144 256 324 576 729 1024 1296 2304

=end code

For that matter, there is no constraint that the "factors" need even be
integers.

=begin code :lang<raku>

put smooth-numbers(1.5,2.5)[^10];

# 1 1.5 2.25 2.5 3.375 3.75 5.0625 5.625 6.25 7.59375

=end code

There I<are> a few constraints:

=begin item
there must be at least one passed factor.
=end item

=begin item
the passed parameters must all be numeric. (Can't exponentiate strings).
=end item

=begin item
the factors must all be greater than or equal to 1 (or the sequence would
be non-ascending).
=end item

Note that if I<any> of the factors is equal to 1, the sequence will return an
infinite series of 1s. Should be obvious why if you think about it.

=head1 AUTHOR

2019 Steve Schulze aka thundergnat

This package is free software and is provided "as is" without express or implied
warranty. You can redistribute it and/or modify it under the same terms as Perl
itself.

=head1 LICENSE

Licensed under The Artistic 2.0; see LICENSE.

=end pod
