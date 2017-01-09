function [colors] = bilinear_interpolate_multiple_flat(flat_texture, dim, channels, points, zeropad)
  % subfunction of bilinear_interpolate_multiple, assuming the texture has
  % already been flattened
  
  %  [ zeropad
  if nargin ~= 5
    zeropad = 0;
  end
  
  out_of_bounds_mask = ( (points(1,:) < 1) + (points(2,:) < 1) + (points(1,:) > dim(2)) + (points(2,:) > dim(1)) ) ~= 0;
  if ~zeropad && sum(out_of_bounds_mask) > 0
    error('error: all points must lie within the texture if zeropad is false');
  end
  within_bounds_mask = out_of_bounds_mask == 0;
  actual_n = size(points,2);
  points = points(:, within_bounds_mask);

  % ]

  [colors] = bilinear_interpolate_multiple_flat_nb(flat_texture, dim, channels, points);

  % [
  if zeropad
    n = size(points,2);
    assert(actual_n >= n);
    ocolors = zeros(channels, actual_n);
    ocolors(:, within_bounds_mask) = colors;
    colors = ocolors;
  end
  % ]