function target_image = imtransform_bilinear_full_homography2(source_image, source_points, target_points, zeropad)
  % same as imtransform_bilinear_full_homography, but constructs the 
  % homography for you using point correspondences
  %
  % if zeropad is true, out-of-range points will be assumed 0
  %
  % *_points are n x 2
  
  if nargin ~= 4
    zeropad = 0;
  end
  
  target_image = imtransform_bilinear_full_homography(source_image, homography2d(target_points, source_points), zeropad);
  