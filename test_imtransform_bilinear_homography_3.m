% prototypes panorama_stitch 
image1 = (imreaddouble('panorama2_left.jpg')); % 'panorama(1|2)_left.jpg'
image2 = (imreaddouble('panorama2_right.jpg')); % 'panorama(1|2)_left.jpg'

best_h = panorama_stitch_homography(image1, image2);
[target_data_range, target_size] = panorama_stitch_get_boundaries(image1, image2, best_h);

mask = boundary_distance_mask_manhattan2(size12(image1));

source_data_range = [1 imageWidth(image1) 1 imageHeight(image1)];

i1 = imtransform_bilinear_homography(image1, inv(best_h), source_data_range, target_data_range, target_size);
i2 = imtransform_bilinear_homography(image2, eye(3), source_data_range, target_data_range, target_size);
i1m = imtransform_bilinear_homography(mask, inv(best_h), source_data_range, target_data_range, target_size);
i2m = imtransform_bilinear_homography(mask, eye(3), source_data_range, target_data_range, target_size);

i = imblend(i1,i1m,i2, i2m);
close all
imshow_in_figure(i, 'final result');
