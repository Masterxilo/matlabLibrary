function gauss = gaussian2d_unnormalized(len, sigma)
  % reference implementation, similar to unnormalized
  % fspecial('gaussian'
  w = (len-1)/2;
  distances2 = repmat(-w:w, len, 1).^2;
  distances2 = distances2 + repmat((-w:w)', 1, len).^2;

  gauss = exp(-distances2 / (2*sigma^2));