close all

source_points = run_ans('rectification1_rect_matlab.m');
target_points = run_ans('rectification1_rect_target_matlab.m');

source_image = imreaddouble('rectification1_rect.png');
imshow_in_figure(source_image, 'source image and points');
hold on
scatter2(source_points);

target_image = imtransform_bilinear_full_homography2(source_image, source_points, target_points);

imshow_in_figure(target_image, 'result and target points');
hold on
scatter2(target_points);