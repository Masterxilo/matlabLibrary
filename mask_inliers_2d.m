function m = mask_inliers_2d(p1, p2, dist_threshold)
  % compute euclidean distance between corresponding points,
  % set m(i) to true if p1(i) is within dist_threshold of p2(i), to false otherwise
  %
  % p* is 2 x n
  % m has length n and islogical
  
  n = size(p1, 2);
  assert(size(p2, 2) == n);
  assert(size(p1,1) == 2);
  assert(size(p2,1) == 2);
  assert(isreal(p1));
  assert(isreal(p2));
  
  d = p1 - p2;
  d = d(1,:) .^ 2 + d(2,:) .^ 2;
  d = sqrt(d);
  
  m = d <= dist_threshold;
  assert(islogical(m));
  assert(length(m) == n);