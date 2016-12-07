function err = linear_solve_error(a, b, x)
  assert(ismatrix(a));
  assert(iscolumn(b));
  err = norm(a * x - b);