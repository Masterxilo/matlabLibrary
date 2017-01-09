function n = sqrnorm(x)
  % squared 2-norm of a vector
  assert(isrow(x) || iscolumn(x));
  assert(isreal(x));
  
  %n = norm(x) ^ 2;
  % equivalently:
  n = dot(x,x);