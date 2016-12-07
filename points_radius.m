function radius = points_radius(points)
  % omputes the mean points of the dxn matrix points
  % and then the average norm of the difference
  assert(isreal(points));
  assert(ismatrix(points));
  n = size(points, 2);
  
  c = mean(points, 2);
  assert(iscolumn(c));
  
  points_centered = points - repmat(c, 1, n);
  
  radius = mean_norm(points_centered);