function y = cartesian_to_homogeneous_dn(x)
  % appends to a d x n array of d-dimensional points a row of ones
  assert(isreal(x));
  y = [x;repmat(1,1,size(x,2))];