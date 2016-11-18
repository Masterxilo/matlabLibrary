function B = movingAverageCircular1(A, n)
  % B = movingAverageCircular1(A, n)
  % A a matrix
  % n an odd number
  %
  % B will be a matrix of the same size as A
  %
  % Computes an n-moving average in the matrix A interpreted circularly
  % along the first dimension.
  %
  % equivalent to imfilter(A, repmat(1, [n 1])/n, 'circular'), cannot be
  % done with conv2
  %
  
  assert(length(size(A)) == 2);
  assert(oddQ(n));
  assert(n >= 3);
  
  width = matrixWidth(A);
  
  for i=1:width
    A(:,i) = movingAverageCircularVector(A(:,i)', n); 
  end
  B = A;