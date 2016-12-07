% choose dataset
[points1, points2] = CV02_bscp_points3(); [image1, image2] = CV02_bscp_images3();
[points1, points2] = CV02_bscp_points2(); 'or CV02_bscp_points2'; image1 = imreaddouble('bs.left.cp.jpg'); image2 = imreaddouble('bs.right.cp.jpg');

% Prepare

points1 = cartesian_to_homogeneous_dn(points1'); % note the homogenization
points2 = cartesian_to_homogeneous_dn(points2');

F = eightPointsAlgorithm(points1, points2);

% visualize result

close all

% show epipolar lines of image2 points in image1
% Any feature given in image2 lies somewhere on the corresponding epipolar
% line in image1. The epipolar line is the projection of the ray going
% through the corresponding point in the other camera view.
%
% The epipolar lines meet (approximately) in the epipole.

showEpipolarLines(image1, points1, image2, points2, F);
