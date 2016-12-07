[x,y,w,h] = FindLargestRectangle([1 1 0;1 1 0;1 1 0;1 1 0]);
assert_equal([x,y,w,h], [1 1 2 4]);

[x,y,w,h] = FindLargestRectangle([0 0 0;1 1 0;1 1 0;1 1 0;1 1 0]);
assert_equal([x,y,w,h], [1 2 2 4]);