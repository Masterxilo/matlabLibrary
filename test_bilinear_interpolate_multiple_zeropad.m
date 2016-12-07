i = single_color_rgb_image([1 2], [1 1 1]);
assert_equal(bilinear_interpolate_multiple(i, [
  0 1 2 3
  1 1 1 1
  ], 1),[
     0     1     1     0
     0     1     1     0
     0     1     1     0
     ]);