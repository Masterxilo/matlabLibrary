assert_equal(boundary_distance_mask_manhattan([3 3]), [1 1 1;1 2 1;1 1 1]);

close all
mask = boundary_distance_mask_manhattan([6 8]);
imshow_in_figure(rescale1(mask), 'small image')


mask = boundary_distance_mask_manhattan([480 640]);
imshow_in_figure(rescale1(mask), 'large image')