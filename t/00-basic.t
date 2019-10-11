use Test;

use Smooth::Numbers;

plan 9;

is(smooth-numbers(2,3)[^15].Str, '1 2 3 4 6 8 9 12 16 18 24 27 32 36 48',
  'Pierpont numbers ok');

is(smooth-numbers(2,3,5)[^15].Str, '1 2 3 4 5 6 8 9 10 12 15 16 18 20 24',
  'Hamming numbers ok');

is(smooth-numbers(2,3,5,7)[^15].Str, '1 2 3 4 5 6 7 8 9 10 12 14 15 16 18',
  'Humble numbers ok');

is(smooth-numbers(5,7)[^15].Str, '1 5 7 25 35 49 125 175 245 343 625 875 1225 1715 2401',
  'ok with skipped prime factors');

is(smooth-numbers(5)[^15].Str, '1 5 25 125 625 3125 15625 78125 390625 1953125 9765625 48828125 244140625 1220703125 6103515625',
  'ok with only 1 factor');

is(smooth-numbers(4,9)[^15].Str, '1 4 9 16 36 64 81 144 256 324 576 729 1024 1296 2304',
  'ok with non-prime factors');

dies-ok( { smooth-numbers() },
  'Dies ok if no passed parameters');

dies-ok( { smooth-numbers(2,3,'c') },
  'Dies ok with non-numerics');

dies-ok( { smooth-numbers(0,2) },
  'Dies ok if parameter < 1');

done-testing;
