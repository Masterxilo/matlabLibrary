function B = rescale1(A)
  % rescale without shifting the values in A such that the maximum value becomes 1
  B = A ./ maxX(A);