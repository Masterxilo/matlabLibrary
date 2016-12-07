% Panorama stitching via sift descriptor matching & homographies
% for Computational Photography hs2016, Project 05 (P8050).
%
% Using sift features and ransac to match them we compute a homography
% that matches features in one image to the same features in the other
%
% See html/ for a published version of a run of this.

% can use any images with sufficient overlap, order does not matter
% however, downsample hd images, matlab isnot big data ready ;)
image1 = imdownsample( imdownsample( imreaddouble('panorama3_left.jpg')));
image2 = imdownsample( imdownsample( imreaddouble('panorama3_right.jpg')));

%% Show the images
close all;
imshow_in_figure(image1);
imshow_in_figure(image2);

%% panorama-stitch the images using the technique required
% This will take a while.
%
% homography2d_ransac2 recomputes the homography using all inliers again,
% unlike homography2d_ransac. But there is not much difference
close all;
[final_image, image_mask] = panorama_stitch(image1, image2, @homography2d_ransac2);
imshow_in_figure(final_image);

%% We can automatically crop the images
% This will take a while.
close all;
final_image_cut = imcutrect(final_image, image_mask);
imshow_in_figure(final_image_cut);

%% panorama-stitch the images with the other image unchanged
close all;
[final_image, image_mask] = panorama_stitch(image2, image1, @homography2d_ransac2);
imshow_in_figure(final_image);


