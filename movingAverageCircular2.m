function B = movingAverageCircular2(A, n)
  % B = movingAverageCircular1(A, n)
  % A a matrix
  % n an odd number
  %
  % B will be a matrix of the same size as A
  %
  % Computes an n-moving average in the matrix A interpreted circularly
  % along the second dimension.
  %
  % equivalent to imfilter(A, repmat(1, [1 n])/n, 'circular')
  %
  
  assert(length(size(A)) == 2);
  assert(mod(n,2) == 1);
  assert(n >= 3);
  
  height = matrixHeight(A);
  
  for i=1:height
    A(i,:) = movingAverageCircularVector(A(i,:), n); 
  end
  B = A;