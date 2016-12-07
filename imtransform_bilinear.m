function target_image = imtransform_bilinear(...
  source_image, ...
  source_data_range, ...
  target_data_range, ...
  target_size, ...
  f, ...
  zeropad,  ... % optional
  f_is_vectorized ... % optional
  )
  % Constructs an image of size target_size, from source_image.
  % The target_image is treated as if it had coordinates ranging over
  % target_data_range in its region, source_image as if it ranged over
  % source_data_range.
  %
  % The color at 'position' x in the target_image will then be given by
  % the color at f(x) in the source_image.
  %
  % All transformed coordinates must land within the original image.
  %
  % source_image is an image of any amount of channels
  % *_range is in the axis limits format [xmin xmax ymin ymax] 
  % target_size is [height width]
  % f is a function_handle to a function R^2 -> R^2, (x,y) -> (x', y')
  %  the function must map target_data_range into a subset of source_data_range
  %
  % Similar to imtransform, but the interpolation is only bilinear.
  %
  % zeropad is optional. If true, points landing outside the image are
  % black instead of undefined.
  %
  % f_is_vectorized is optional. If true, f is applied not via arrayfun
  % but is passed the entire 2 x n matrix of points in the target coordinate system
  % which it should map into the source data points (where the texture will
  % be looked up).
  
  if nargin < 6
    zeropad = 0;
  end
  
  if nargin < 7
    f_is_vectorized = 0;
  end
  
  assert(isimage(source_image));
  assert(isaxis_limits(source_data_range));
  assert(isaxis_limits(target_data_range));
  assert(all(target_size > 0));
  assert(length(target_size) == 2);
  assert(isreal(target_size));
  assert(isfunction_handle(f));
  
  target_range = [1 target_size(2) 1 target_size(1)];
  target_points = coordinates_list_2n_2(target_range);
  target_dpoints = rescale_points2n(target_points, target_range, target_data_range);
  
  assert(all(target_dpoints(1,:) <= target_data_range(2))); % sanity
  
  if f_is_vectorized
    source_dpoints = f(target_dpoints);
  else
    source_dpoints = arrayfun2(f,target_dpoints(1,:),target_dpoints(2,:)); % this takes a while
  end
  
  assert_same_size(source_dpoints, target_dpoints);
  
  if ~zeropad % catch out-of bounds points early
    assert_in_range(source_dpoints(1,:), source_data_range(1), source_data_range(2));
    assert_in_range(source_dpoints(2,:), source_data_range(3), source_data_range(4));
  end
  
  source_range = [1 size(source_image,2) 1 size(source_image,1)];
  source_points = rescale_points2n(source_dpoints, source_data_range, source_range);
 
  if false % debug
  figure()
  scatter2(source_dpoints)
  title('source dpoints')
  
  figure()
  scatter2(target_points)
  title('target points')
  
  figure()
  scatter2(source_points)
  title('source points')
  end
  
  target_image_flat = bilinear_interpolate_multiple(source_image, source_points, zeropad);
  %size(target_image_flat)
  %size(shiftdim(target_image_flat,1))
  target_image = reshape(shiftdim(target_image_flat,1), [target_size size(source_image, 3)]);
  %size(target_image)
  assert_equal(size12(target_image), target_size);
  assert_equal(size(target_image, 3), size(source_image, 3));
  
  