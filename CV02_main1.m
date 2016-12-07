% Computer Vision project 2 part 1, c.f. P8129

close all

%% Let the user select corresponding points on the two images, at least eight
% Alternatively, use saved points form an earlier run.

% datasets with default points:
[image1, image2] = CV02_bscp_images3(); [points1, points2] = CV02_bscp_points3();
[image1, image2] = imreaddouble_halves('Apollo_stereo.jpg'); load('apollo_points.mat');

manuallySelectPointsQ = false;

if manuallySelectPointsQ
  close all
  [points1, points2] = cpselect_1(image1, image2);
end

assert_same_size(points1, points2);
assert(size(points1,1) >= 8); % must select enough points

disp('selection ok');

%% Make points homogeneous, necessary for the next step
points1 = cartesian_to_homogeneous_dn(points1'); % note the homogenization
points2 = cartesian_to_homogeneous_dn(points2');

%% Computing the fundamental matrix between the two images
F = eightPointsAlgorithmImpl1(points1,points2); % Impl1|2 % Impl2 sometimes worse? solves some other problem?
  % maybe bad if the images have almost the same orientation, i.e. if the
  % epipolar lines are almost horizontal

% check the matrix
for i=1:size(points1,2)
  disp(['reprojection error: ' num2str(points2(:,i)' * F * points1(:,i))]);
    %assert(points2(:,i)' * F * points1(:,i) < 1e-6);
end

F
disp('fundamental matrix ok');

%% Visualize epipolar lines for the provided points
close all
showEpipolarLines(image1, points1, image2, points2, F);

%% Epipolar lines for user points
%close all
fig = imshow_in_figure(image1, 'image1 user selected points');
uiwait_msgbox('Select points in image1 to later show the corresponding epipolar lines in image 2 (the selected feature should be on this line). ');
[xs, ys] = getpts(fig); %ginput(1);
hold on
scatter(xs, ys);

imshow_in_figure(image2, 'image2 user selected corresponding epipolar lines');
hold on
[rows cols ~] = size(image1);

for i=1:length(xs)
    x = [xs(i);ys(i);1];
    
    % Question 4
    % Draw epipolar line for it:
    % All points xp = (u v 1) with xp' * F * x = xp' * y == 0
    line_implicit_dot_homogeneous(rows, cols, F * x);
end

%% Compute epipoles (intersection point of epipolar lines)
% Possibly outside of images

% In left view
imshow_in_figure(image1, 'image1 epipole');
hold on
% F * e = 0
epipoleLeft = F(:,[1 2])\(-F(:,3))
scatter(epipoleLeft(1), epipoleLeft(2))

% in right view
imshow_in_figure(image2, 'image2 epipole');
hold on
% F' * e' = 0
F = F';
epipoleRight = F(:,[1 2])\(-F(:,3))
scatter(epipoleRight(1), epipoleRight(2))
