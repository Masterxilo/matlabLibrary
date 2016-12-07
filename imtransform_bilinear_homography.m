function o = imtransform_bilinear_homography(source_image, inverse_homography_matrix, ...
  source_data_range, ...
  target_data_range, ...
  target_size)
% *_data_range might e.g. come from image_data_range(image)
% target size might be just size12(source_image), must be of the format
% [height width]
%
% Uses zeropadding by default.

  f = @(p2n) homogeneous_to_cartesian_dn(inverse_homography_matrix * cartesian_to_homogeneous2d(p2n));
  disp('imtransform_bilinear_homography in progress (vectorized)...');

  f_is_vectorized = 1;
  zeropad = 1;
  o = imtransform_bilinear(source_image, source_data_range, target_data_range, target_size, f, zeropad, f_is_vectorized);
  
  assert(all(size12(o) == target_size));
