function y = homogeneous_to_cartesian(x)
  % converts a single vector from homogeneous to cartesian coordinates
  % by dividing through the last component which is assumed nonzero
  
  n = length(x);
  assert(isrow(x) || iscolumn(x));
  % divides by t
  y = x(1:end-1)/x(n);