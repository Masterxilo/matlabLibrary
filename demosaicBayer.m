function out = demosaicBayer(img)
    % similar to C53 (LerpDebayer), but operates on doubles in [0,1].
    %
    % img is a m x n 2D matrix that represents a color image using a Bayer
    % pattern
    % out is a m * n * 3 matrix that represents a color image with per
    % pixel RGB values
    %
    % All color values should be in [0,1]
    
    assert(ismatrix(img));
    
    [maskR, maskG, maskB] = demosaicBayerMakeMasks(size(img));
    
    % Apply
    maskedR = maskR .* img;
    maskedG = maskG .* img;
    maskedB = maskB .* img;
    
    % Convolve & normalize
    totalR = conv2(maskedR, ones(3), 'same');
    totalMaskR  = conv2(maskR, ones(3), 'same');
    averageR = totalR ./ totalMaskR;
    
    totalG = conv2(maskedG, ones(3), 'same');
    totalMaskG  = conv2(maskG, ones(3), 'same');
    averageG = totalG ./ totalMaskG;
    
    totalB = conv2(maskedB, ones(3), 'same');
    totalMaskB  = conv2(maskB, ones(3), 'same');
    averageB = totalB ./ totalMaskB;
    
    % Recombine with masked* 
    % use original color where defined
    finalR = maskedR + (1-maskR) .* averageR;
    finalG = maskedG + (1-maskG) .* averageG;
    finalB = maskedB + (1-maskB) .* averageB;
    
    % out
    out = zeros([size(img) 3]);
    out(:,:,1) = finalR;
    out(:,:,2) = finalG;
    out(:,:,3) = finalB;