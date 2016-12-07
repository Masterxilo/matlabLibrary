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
    
    %  [ zeropad
    if nargin ~= 3
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
    
    n = size(points,2);
    channels = size(texture,3);
    
    flat_texture = reshape(shiftdim(texture,2), channels, arrayProduct(dim)); % list of colors, accessing texture via sub2ind(dim, x) style indices
    
    
    % nearest neighbor coordinates in all directions
    points00 = floor(points);
    points10 = [ceil(points(1,:));floor(points(2,:))];
    points01 = [floor(points(1,:));ceil(points(2,:))];
    points11 = ceil(points);
    
    uv = points - points00;
    
    % do lookups
    points00i = sub2ind(dim, points00(2,:), points00(1,:));
    points01i = sub2ind(dim, points01(2,:), points01(1,:));
    points10i = sub2ind(dim, points10(2,:), points10(1,:));
    points11i = sub2ind(dim, points11(2,:), points11(1,:));
    
    % texture fetches
    t00 = flat_texture(:, points00i);
    t01 = flat_texture(:, points01i);
    t10 = flat_texture(:, points10i);
    t11 = flat_texture(:, points11i);
    
    assert_equal(size(t00), [channels n]);
    
    % weights are
    u = uv(1,:);
    v = uv(2,:);
    w00 = (1-u) .* (1-v);
    w10 = u .* (1-v);
    w01 = (1-u) .* v;
    w11 = u .* v;
    
    
    % extend weights to have same amount of rows as texture has channels
    % for later pointwise multiply
    w00 = repmat(w00,channels,1);
    w10 = repmat(w10,channels,1);
    w01 = repmat(w01,channels,1);
    w11 = repmat(w11,channels,1);
    
    % weight texture samples and add up
    colors = w00 .* t00 +  w10 .* t10 +  w01 .* t01 +  w11 .* t11;
    
    % [
    if zeropad
      assert(actual_n >= n);
      ocolors = zeros(channels, actual_n);
      ocolors(:, within_bounds_mask) = colors;
      colors = ocolors;
    end
    % ]
    