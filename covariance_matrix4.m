function d = covariance_matrix4(sigmas)
  % for passing to gaussian4
  assert(length(sigmas) == 4);
  d = diag(1 ./ sigmas.^2);