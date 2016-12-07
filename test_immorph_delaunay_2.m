% This stereo pair was not set up for morphing, but we do it just because
% we can!

% Choose any dataset of corresponding points and respective images
[points1, points2] = CV02_bscp_points(); 'or CV02_bscp_points2'; image1 = imreaddouble('bs.left.cp.jpg'); image2 = imreaddouble('bs.right.cp.jpg');
[points1, points2] = CV02_bscp_points3(); [image1, image2] = CV02_bscp_images3();

close all

imshow_in_figure(image1, 'image1');
hold on
scatter2(points1');
imshow_in_figure(image2, 'image2');
hold on
scatter2(points2',  'r');


imshow_in_figure(immorph_delaunay(image1, points1, image2, points2, 0.5), 'halfway blend in convex hull of corresponding points')
hold on
scatter2(points1');
scatter2(points2',  'r');