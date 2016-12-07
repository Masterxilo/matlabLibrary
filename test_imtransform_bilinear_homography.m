i1 = (imreaddouble('panorama2_left.jpg')); % 'panorama(1|2)_left.jpg'

h1to2 = [
    1.0000   -0.0453 -720.0167
    0.1139    0.9449  -82.5851
    0.0002   -0.0000    0.7741
    ];
  
close all
imshow_in_figure(imtransform_bilinear_full_homography(i1, inv(h1to2), 1), 'i1 full'); 

es = [1 imageWidth(i1) 1 imageHeight(i1)];
et = es - [imageWidth(i1)/2 imageWidth(i1)/2 imageHeight(i1)/2 imageHeight(i1)/2];
imshow_in_figure(imtransform_bilinear_homography(i1, inv(h1to2), es, et, size12(i1)), 'i1 shifted'); 

