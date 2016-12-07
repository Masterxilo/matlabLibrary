
assert_equal(rescale_points2n([1 2;1 3], [1 2 1 3], [0 4 0 5]), [0 4;0 5])

s = [1   100     1   100];
assert_equal(rescale_points2n([0;0], [0 1 0 1], s), [1;1])