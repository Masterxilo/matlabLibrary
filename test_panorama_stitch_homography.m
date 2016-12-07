close all
i1 = (imreaddouble('panorama2_left.jpg')); % 'panorama(1|2)_left.jpg'
i2 = (imreaddouble('panorama2_right.jpg')); % 'panorama(1|2)_left.jpg'

imshow_in_figure(i1, 'image 1');
imshow_in_figure(i2, 'image 2');

h1to2 = panorama_stitch_homography(i1, i2)

i1in2 = imtransform_bilinear_full_homography(i1, inv(h1to2), 1);
imshow_in_figure(i1in2, 'image 1 in image 2');

i2in1 = imtransform_bilinear_full_homography(i2, h1to2, 1);
imshow_in_figure(i2in1, 'image 2 in image 1');

% 
imshow_in_figure(imfillholes(i1in2, i2), 'image 1 in image 2 with holes filled using image2');
imshow_in_figure(imfillholes(i2in1, i1), 'image 2 in image 1 with holes filled using image1');