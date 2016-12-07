function m = count_inliers_2d(p1, p2, dist_threshold)
  % compute euclidean distance between corresponding points,
  % count the amount of pairs that are closer than dist_threshold
  %
  % p* is 2 x n
  
  n = size(p1, 2);
  m = sum(mask_inliers_2d(p1, p2, dist_threshold));
  assert(m >= 0 && m <= n);