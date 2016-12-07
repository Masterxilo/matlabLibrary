function [normals, albedo] = CV01_estimateNormalsAndAlbedo(L, colorImages, maskImage)
  %
  % L: 3 x nDir list of light source directions
  %
  % colorImages: height x width x 3 x nDir list of color images of an object 
  %     the object occupies all pixels with a 1 in the mask image
  %     it is always photographed from the same viewpoint
  %     in the i-th image, the light comes from direction L(i,:)
  %     coordinate system: x points to the right, y down and z away from the camera so that we obtain a right-handed coordinate system.
  %     All lightsources are assumed to come from behind the camera, that is, L(:,3) is always negative.
  % maskImage: height x width matrix of 0 and 1, 1 where the colorImage depicts an object
  
  % normals: estimated per pixel normals, valid where mask is 1
  %     an [N, M, 3] matrix of surface normals (or zeros
  %      for no available normal)
  %  note that z of each normal will be negative (pointing towards the
  %  camera)
  % albedo: estimated color albedo of the object

  %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % PART 2: Fit surface normals and the albedo for pixels within 
  %         the object mask using the images for which corresponding 
  %         images of the chrome sphere (and hence light source 
  %         directionss) are available.
  assert(isdouble(colorImages));
  assert(islogical(maskImage));
  
  [height, width, ~, nDir] = size(colorImages);
  assert_equal(size(L), [3 nDir]);
  
  % Preliminary black-white albedo (intensity)
  albedo = zeros(height, width); % -- no need to store, implicit
  normals = zeros(height, width, 3);
  
  %for i=1:nDir
  %  greyScaleImages = rgb2gray(colorImages(:,:,:,i)); % or  mean(a,3) % mean along 3rd dimension
  %end
  greyScaleImages = mean(colorImages,3);
  
  
  hw = waitbar_start('CV01 estimateNormalsAndAlbedo ...');
  
  for y=1:height
    waitbar(y/height, hw);
  for x=1:width
    if ~maskImage(y,x)
      continue;
    end
    % For each pixel individually, compute an estimate for the 
    % normal n and (grey)
    % albedo a, given the known light direction/intensities and 

    % That is, solve the following in the leastsquares sense:
    % I(i) = a * (dot(n,L(i)))  for each light i

    % # Turning this into a linear leastsquares problem
    % Combining a and n:
    % L(i).an == I(i)  for each light i

    % This is then a linear system of equations:
    % A * x = b
    % where (column vectors)
    % an = (an1 an2 an3)
    % and 
    % b = (I(1) ... I(12))
    % and
    % A = [
    % L(1,1) L(1,2) L(1,3)
    % ...
    % L(12,1) L(12,2) L(12,3)
    % ]

    % We have
    % argmin_x norm(A*x-b) 
    % --> x = pinv(A)*b 
    A = L';
    
    vec = @(x) x(:);
    b = vec(greyScaleImages(y,x,1,:));
        
    % [[ shadowfix: (TODO make this an option)
    % Trick to give less weight to dark regions: weight equations by brightness
    % cf. Slide 20
    A = [b b b] .* A;
    b = b .* b; 
    % ]]

    % Solve
    an = pinv(A)*b;

    % Normalize an to get a and n
    a = norm(an);
    normals(y,x, :) = an/a;
    albedo(y,x) = a;
  end
  end
  
  close(hw);