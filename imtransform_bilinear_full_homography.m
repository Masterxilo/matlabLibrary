function o = imtransform_bilinear_full_homography(source_image, inverse_homography_matrix, zeropad)
  % inverse_homography_matrix transforms from the target image's
  % coordinates (which are set to the same as the source_image)
  % to the source_image
  
  if nargin < 3
    zeropad = 0;
  end
  
  % for clamping (sometimes needed because of inaccuracies)
  w = size(source_image, 2);
  h = size(source_image, 1);
  
  % TODO since this is all linear, this can certainly be vectorized to increase the efficiency 
  
  % clamping necessary because of inaccuracies if not zeropadding
  
  f_is_vectorized = 1; % without vectorization, operation is much slower
  
  if f_is_vectorized
    if ~zeropad
      f = @(p2n) min(repmat([w;h],1,size(p2n,2)), max(ones(size(p2n)), ...
        homogeneous_to_cartesian_dn(inverse_homography_matrix * cartesian_to_homogeneous2d(p2n)) ...
        ));
    else
      f = @(p2n) homogeneous_to_cartesian_dn(inverse_homography_matrix * cartesian_to_homogeneous2d(p2n));
    end

    disp('imtransform_bilinear_full_homography in progress (vectorized)...');
    
  else
    
    if ~zeropad
      f = @(x,y) min([w;h], max([1;1], homogeneous_to_cartesian(inverse_homography_matrix * [x;y;1])));
    else
      f = @(x,y) homogeneous_to_cartesian(inverse_homography_matrix * [x;y;1]);
    end

    disp('imtransform_bilinear_full_homography in progress (not vectorized)...'); % this takes a while
  end
  
  o = imtransform_bilinear_full(source_image, f, zeropad, f_is_vectorized);
