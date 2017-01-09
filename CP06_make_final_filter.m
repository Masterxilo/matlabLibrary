function [final, low_angular_bandwidth, low_spatial_bandwidth, low_spatialxangular_bandwidth, ears] = CP06_make_final_filter( ...
  low_angular_bandwidth_angular_std, ...
  low_angular_bandwidth_spatial_std, ...
  low_spatial_bandwidth_angular_std, ...
  low_spatial_bandwidth_spatial_std, ...
  spatial_size, slope ...
  )

  % makes the combined 7 x 7 x spatial_size x spatial_size
  % filter kernel, combining low spatial and low angular bandwidth
  % filters as described in the slides P8153, 52.
  
  % sanity check
  if false
   low_angular_bandwidth_angular_std
  low_angular_bandwidth_spatial_std
  low_spatial_bandwidth_angular_std
  low_spatial_bandwidth_spatial_std
  end
  assert(low_angular_bandwidth_spatial_std < low_spatial_bandwidth_spatial_std);
  assert(low_spatial_bandwidth_angular_std < low_angular_bandwidth_angular_std);
  
  % Make thin-and-long and wide-and-short filter
  low_angular_bandwidth = CP06_make_shear_gaussian4d(low_angular_bandwidth_angular_std, low_angular_bandwidth_spatial_std, spatial_size, slope);
  low_spatial_bandwidth = CP06_make_shear_gaussian4d(low_spatial_bandwidth_angular_std, low_spatial_bandwidth_spatial_std, spatial_size, slope);

  % Convolve to obtain short and thin filter
  low_spatialxangular_bandwidth = convn(low_angular_bandwidth, low_spatial_bandwidth,'same'); % normalize this or not?

  % subtract to obtain 'ears', add ears to 'body'
  ears = low_angular_bandwidth - low_spatialxangular_bandwidth;
  final = normalize_integral(...
    low_spatial_bandwidth + (ears) ...
  );

  %imshow_in_figure(rescale01(squeeze(final(3,:,1,:))), ['gaussian mask with slope ' num2str(slope)]); % show filter

