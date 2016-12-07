function showEpipolarLines(image1, points1, image2, points2, F)
  % F e.g. from eightPointsAlgorithm
  % points1 and points2 are inhomogeneous coordinates
  assert(size(points1,1) == 3);
  
[rows cols ~] = size(image1);
n = size(points1,2);
assert(n >= 8);
assert_same_size(image1, image2);
assert_same_size(points1, points2);
  
imshow_in_figure(image1, 'image1');
hold on
scatter2(points1(1:2,:));
for i=1:n
    line_implicit_dot_homogeneous(rows, cols, points2(:,i)' * F); 
end


% show epipolar lines of image1 points in image2
imshow_in_figure(image2, 'image2');
hold on
scatter2(points2(1:2,:));
for i=1:n
    line_implicit_dot_homogeneous(rows, cols, F * points1(:,i)); 
end
