function B = movingAverageCircular(A, n)
  % B = movingAverageCircular1(A, n)
  % A a matrix
  % n an odd number
  %
  % B will be a matrix of the same size as A
  %
  % Computes an n-moving average in the matrix A interpreted circularly
  % i.e. an n x n box filter
  %
  % equivalent to imfilter(grayImage, ones(n)/n^2, 'circular')
  %
  
  B = movingAverageCircular2(movingAverageCircular1(A, n), n);