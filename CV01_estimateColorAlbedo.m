function [albedo] = CV01_estimateColorAlbedo(L, colorImages, normals, maskImage)
  %
  % L: as in CV01_estimateNormalsAndAlbedo
  % colorImages: height (N) x width (M) x 3 x nDir as in eNAA
  % normals is an [N, M, 3] matrix of surface normals (or zeros
  %      for no available normal)
  %
  % Gives constant global color albedo assuming all lighting information in image i
  % is given by L(i, :) and the normals
  assert(isdouble(colorImages));
  assert(isdouble(normals));
  assert(islogical(maskImage));
  
  [~, nDir] = size(L);
  [height, width, ~] = size(normals);
  albedo = zeros(height, width, 3);
  
  hw = waitbar_start('CV01 estimateColorAlbedo ...');
  
  for y=1:height
    waitbar(y/height, hw);
  for x=1:width
  for channel=1:3
    
    if ~maskImage(y,x)
      continue;
    end
    
  % Solve in leastsquares sense for real number a:
  % for each light i
  
  % I(y,x,channel,i) = a * (dot(n,L(i))) 
  
  % That is, each image i depicts the unknown color a modulated only by the lighting effects. 

    % This is a linear system of equations:
    % A * a = b
    % where (column vectors)
    % b = (I(1) ... I(nDir))
    % A = [dot(n, L(1)) ... dot(n, L(nDir)) ]
    
    vec = @(x) x(:);
    A = L' * vec(normals(y,x,:)); % recall that a matrix-vector product is a column vector of row.vector for each row of the matrix
    b = vec(double(colorImages(y,x,channel,:)));
    a = pinv(A)*b;
    
    albedo(y,x, channel) = a;
    
  end
  end
  end
  
  close(hw);