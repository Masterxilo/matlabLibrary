o = imcutrect(single_color_rgb_image([5 3], [1 1 0]), [0 0 0;1 1 0;1 1 0;1 1 0;1 1 0]);
assert_equal(o(:,:,1), [
     1     1
     1     1
     1     1
     1     1
     ]);
assert_equal(o(:,:,2), [
     1     1
     1     1
     1     1
     1     1
     ]);
assert_equal(o(:,:,3), [
     0     0
     0     0
     0     0
     0     0
     ]);