[v h] = forward_differences2(reshape(1:9,3,3))
assert_equal(v, [1 1 1;1 1 1]);
assert_equal(h, 3*[1 1;1 1;1 1]);