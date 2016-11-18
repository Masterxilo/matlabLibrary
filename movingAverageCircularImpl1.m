function B = movingAverageCircularImpl1(A, n)
  % Computes an n-moving average (n x n box filter) in the matrix A interpreted circularly
  %
  % A a matrix
  % n an odd number
  %
  % B will be a matrix of the same size as A
  
  assert(ismatrix(A));
  assert(oddQ(n));
  
  B = movingAverageCircular2(movingAverageCircular1(A, n), n);