% Image rectification via homography transform
% for Computational Photography hs2016, Project 05 (P8050).
%
% Four points selected on image 1 will be mapped to four points on
% image2, using a homography.
%
% See rectification_tool_example.png for an example run of this

%% Inputs
% could use any 2 images
image1 = lena();
image2 = imreaddouble('rectification1.png');

%% Points in image 1
close all
imshow_in_figure(image1, 'image1, select 4 points');
points1 = ginput2(4);

%% Points in image 2
imshow_in_figure(image2, 'image1, select 4 points the previous points should map to (in the same order)');
points2 = ginput2(4);

%% Compute the transformation
h = homography2d(points1', points2');
assert_same_size12(h, eye(3));

%%
image1t = imtransform_bilinear_homography(image1, inv(h), image_data_range(image1), image_data_range(image2), size12(image2));

% do the same with a mask of the same size
image1tm = imtransform_bilinear_homography(ones(size12(image1)), inv(h), image_data_range(image1), image_data_range(image2), size12(image2));

%% Blend
result = immask_combine(image2, image1t, image1tm);

imshow_in_figure(result, 'result');

