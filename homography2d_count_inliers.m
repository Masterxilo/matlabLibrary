function [m, h] = homography2d_count_inliers(p1, p2, which, dist_threshold)
  % p*      are 2 x n matrices of probably corresponding points
  % which   is a sublist of length at least 4 of 1:n
  %
  % constructs the homography of p1(which) to p2(which),
  % then transforms all of p1 according to this and uses count_inliers_2d
  % on the result
  
  assert_equal(which, floor(which));
  assert(isreal(which)); 
  assert(isrow(which));
  n = size(p1, 2);
  assert_same_size(p1, p2);
  
  h = homography2d(p1(:,which), p2(:,which));
  
  p1t = homography_transform(h, p1);
  
  m = count_inliers_2d(p1t, p2, dist_threshold);
  assert(m >= 0 && m <= n);