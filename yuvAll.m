function yuv = yuvAll(img)
  % Converts an RGB image to a yuv image.
    % img is of size [m n 3]
    % With colors in [0,1]
    assert(isimage(img));
    assert(isdouble(img)); % required for matrix multiplication below
    assert(size(img,3) == 3);
    
    
    [m, n, ~] = size(img);
    
    rgb2yuv = [0.299 0.587 0.114;
    -0.14713 -0.28886 0.436;
    0.615 -0.51499 -0.10001];

    rgbLinear = reshape(shiftdim(img,2), [3 m*n]);
    yuvResult = rgb2yuv * rgbLinear;
    
    yuv = shiftdim(reshape(yuvResult, [3 m n]), 1);