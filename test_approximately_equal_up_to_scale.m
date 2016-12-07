assert(approximately_equal_up_to_scale(1,1.1));
assert(~approximately_equal_up_to_scale([1 2], [4 10]));
assert(approximately_equal_up_to_scale([0 1 2], -3 * [0 1 2]));