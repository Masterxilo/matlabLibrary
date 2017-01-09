function o = CP06_make_shear_gaussian4d(angular_std, spatial_std, spatial_size, slope)
  % 7 x 7 x spatial_size x spatial_size
  % normalized gaussian4d with covariance_matrix_shear4
  
  std = [angular_std, angular_std, spatial_std, spatial_std];
  sz = ceil([7 7 spatial_size spatial_size]); 
  o = gaussian4d(sz, covariance_matrix_shear4(std, slope));

