function normdiff_maxabsdiff = linear_solve_error2(A, b, x)
  normdiff_maxabsdiff = [linear_solve_error(A, b, x), maxabsdiff(A * x, b)];