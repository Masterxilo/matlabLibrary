function points_d = points_dn_add(points, delta)
  n = size(points, 2); 
  points_d = points + repmat(delta, 1, n);