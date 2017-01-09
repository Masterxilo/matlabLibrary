function gaussian_nd(S)
  % normalized n-dimensional gaussian
  % S is the covariance matrix
  assert(size(S,1) == size(S,2));
  assert(ismatrx(S));
  assert(isreal(S));
  
  % TODO implement
  %ndgrid