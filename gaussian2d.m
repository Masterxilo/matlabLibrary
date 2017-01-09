function gauss = gaussian2d(len, sigma)
  % equivalent to fspecial('gaussian', len, sigma)
  % a good choice for len is  len = 2*w + 1; for
  % w = ceil(1.5 * sigma_s);
  %
  % reference implementation
  
  gauss = normalize_integral( gaussian2d_unnormalized(len, sigma) );