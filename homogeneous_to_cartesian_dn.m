function y = homogeneous_to_cartesian_dn(x)
  % converts a list of d-dimensional vectors, in a vector d x n
  % from homogeneous to cartesian coordinates
  % by dividing through the last component which is assumed nonzero
  h = size(x, 1);
  y = x(1:h-1,:) ./ repmat(x(h,:),2,1);