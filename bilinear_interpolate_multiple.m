function [colors] = bilinear_interpolate_multiple(texture, points, zeropad)
  % returns a list of n colors (as a 'channels x n' matrix)
  % obtained by evaluating texture at each point
  %
  % all points must lie within the texture (unless zeropad is specified), i.e. 1:width, 1:height
  % but they can be non-integral
  %
  % points is 2xn 
  % texture is a color or grayscale image
  % zeropad is optional. use zeropad = 1 to indicate
  %  that out-of-bounds points should be assigned 0. Other
  assert(isreal(texture));assert(isdouble(texture)); % support only floating point images
  assert(isimage(texture));
  assert(ismatrix(points));
  assert(size(points,1) == 2);

  dim = size12(texture);
  channels = size(texture,3);

  flat_texture = reshape(shiftdim(texture,2), channels, arrayProduct(dim)); % list of colors, accessing texture via sub2ind(dim, x) style indices
  %  [ zeropad
  if nargin ~= 3
    zeropad = 0;
  end
  % ]

  [colors] = bilinear_interpolate_multiple_flat(flat_texture, dim, channels, points, zeropad);

