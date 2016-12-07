P = [0 1 2; -1 -2 -0.5];
assert_equal(minmax2(P), [-1 -2 -0.5;0 1 2]);
assert_equal(minmax(P), [         0    2.0000
   -2.0000   -0.5000]);