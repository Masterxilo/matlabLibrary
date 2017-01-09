function sm1 = covariance_matrix_shear4(sigmas, slope)
  % For computational photography project 06
  % computes sigma^-1 as specified in the task.
  %
  % This can be used to construct a gaussian4d that will 
  % filter such that the given slope is blurred the least.
  % This can be used to focus a light field
  % to a certain depth (corresponding to a parallax shift speed/slope
  %
  % Note that the shear is applied to the final two components,
  % based on the values of the first two components 
  % make sure this makes sense with the order of components you use.
  %
  % If slope is 0, this corresponds to covariance_matrix4
  %
  % If we call the coordinates (x,y,z,w)
  % this will shear x as z increases and y as w increases (displayed via multiple 3d slices below)
  % c.f. test_covariance_matrix_shear4
  
  d = diag(1 ./sigmas.^2);
  
  s = [1 0 0 0;0 1 0 0;slope 0 1 0;0 slope 0 1];
  
  sm1 = s' * d * s;