function o = rescale_points2n(points2n, axis_limitsFrom, axis_limitsTo)
  % Similar to rescale01 but for 2d points in a list of dimensions 2xn
  % and arbitrary target range
  %
  assert(isaxis_limits(axis_limitsFrom));
  assert(isaxis_limits(axis_limitsTo));
  assert(size(points2n, 1) == 2);
  assert(isreal(points2n));
  
  n = [
    (points2n(1,:) - axis_limitsFrom(1))/(axis_limitsFrom(2) - axis_limitsFrom(1))
    (points2n(2,:) - axis_limitsFrom(3))/(axis_limitsFrom(4) - axis_limitsFrom(3))
    ];
  
  o = [
    n(1,:)*(axis_limitsTo(2) - axis_limitsTo(1)) + axis_limitsTo(1)
    n(2,:)*(axis_limitsTo(4) - axis_limitsTo(3)) + axis_limitsTo(3)
    ];
  
  assert_same_size(o, points2n);
  