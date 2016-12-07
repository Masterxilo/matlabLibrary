function o = imtransform_bilinear_full(image, f, zeropad, f_is_vectorized)
  % same as imtransform_bilinear, but sets all coordinate ranges
  % from the image
  if nargin < 3
    zeropad = 0;
  end
  
  if nargin < 4
    f_is_vectorized = 0;
  end
  
  o = imtransform_bilinear(image, image_data_range(image), image_data_range(image), size12(image), f, zeropad, f_is_vectorized);