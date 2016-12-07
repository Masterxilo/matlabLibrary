function c = centroid_dn(x)
  % computes the centroid i.e. average point (center of mass)
  % of a d x n matrix of points in d-dimensional space
  c = mean(x, 2);