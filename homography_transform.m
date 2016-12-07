function p1t = homography_transform(h, p1)
  % transforms a list of points 2 x n according to the homography h
  p1t = homogeneous_to_cartesian_dn(h * cartesian_to_homogeneous2d(p1));