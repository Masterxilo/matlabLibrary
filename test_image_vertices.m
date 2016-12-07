i = imreaddouble('panorama1_left.jpg');
assert_equal(image_vertices(i), [
     1   345   345     1
     1     1   230   230
     ]);