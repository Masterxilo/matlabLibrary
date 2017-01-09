function gauss = gaussian4d_unnormalized(out_size, S)
  % c.f. gaussian2d_unnormalized
  % this supports an arbitrary covariance matrix and different dimensions
  % in each direction
  %
  % size(gauss) == out_size
  %
  % S is the (inverse) covariance matrix, containing the (inverse) variances (on the diagonal)
  % and the distortion into an ellipse... The matrix is usually positive
  % definite? (and symmetric?) such that it defines an inner product.
  
  %
  
  assert(size(S,1) == size(S,2));
  assert(size(S,1) == 4);
  assert(ismatrix(S));
  assert(isreal(S));
  
  assert(length(out_size) == 4);
  assert(isrow(out_size));
  assert(isinteger_double(out_size));
  
  % centering according to same formula as gaussian2d
  w = (out_size - 1) / 2;
  assert(length(w) == 4);
  
  % z-mu matrices (mu is simply at the center)
  [X1, X2, X3, X4] = ndgrid(-w(1):w(1), -w(2):w(2), -w(3):w(3), -w(4):w(4));
  
  % Reshape into 4 x N list of coordinates
  % i.e. c = Table[{x,y,z,d},
  % {d,-w,w}, {z,-w,w}, {y,-w,w}, {x,-w,w}]~Level~{-2}
  % == CoordinateBoundsListReversed[{-w,w}~Table~3]
  % note that the first component varies most quickly
  
  x = [X1(:)'; X2(:)'; X3(:)'; X4(:)'];
  assert(size(x,1) == 4);
  
  % Compute the 'inner product' determined by S,
  % (1) z^T . S . z for each z in x.
  
  % [[ Computing (1):
  
    % equivalent
    y1 = dot(x, S * x);
    
  if false
    % this is what the exercise description says we should do:
    % It is equivalent (for symmetric S?) because 
    %
    % dot(sqrtm(S) * x, sqrtm(S) * x)
    % = x' * sqrtm(S)' * sqrtm(S) * x 
    % = x' * S * x
    
    y2 = sqrtm(S) * x;
    y2 = y2 .^ 2; y2 = sum(y2); % equivalent to dot(y2, y2) = sqrnorm(y2, y2)
    
    %assert_approximately_equal(y1, y2); % this holds true
  end
  % ]]
  
  y = y1;
   
  assert(size(y,1) == 1);
  assert(size(y,2) == arrayProduct(out_size));
  
  % compute exp(-1/2 y)
  z = exp(-1/2 * y);
  
  % reshape again (TODO is the order of components/dimensions preserved correctly?)
  gauss = reshape(z, out_size);
  
  
  assert_equal(size(gauss), out_size);