function out = demosaicBayerMedian(img)
    % img is a m x n 2D matrix that represents a color image using a Bayer
    % pattern
    % out is a m * n * 3 matrix that represents a color image with per
    % pixel RGB values
    
    % All color values should be in [0,1]
    
    % 1.Linear interpolation on RGB color channels
    lerpRGB = demosaicBayer(img);
    
    % 2. convert to YUV, keep U and V only
    [~, u, v] = yuv(lerpRGB);
    
    % 3. Median filter u,v
    medfilt_u = medfilt2(u, [5 5]);
    medfilt_v = medfilt2(v, [5 5]);
    
    % 4. Reconstruct RGB image 
    % Prepare
    maskR = zeros(size(img));
    maskG = maskR;
    maskB = maskR;
    
    maskR(1:2:end, 1:2:end) = 1;
    
    maskG(2:2:end, 1:2:end) = 1;
    maskG(1:2:end, 2:2:end) = 1;
    
    maskB(2:2:end, 2:2:end) = 1;
    
    maskedR = maskR .* img;
    maskedG = maskG .* img;
    maskedB = maskB .* img;
    
    % Red: Solve for G and B
    % Solve[U == -0.14713 R - 0.28886 G + 0.436 B && 
    % V == 0.615 R - 0.51499 G - 0.10001 B, {G, B}]
    % {{G -> 1. R - 0.394634 U - 1.72043 V, 
    %   B -> 0.99998 R + 2.03212 U - 1.13983 V}}
    R_R = maskedR;
    R_G = (1. * R_R - 0.394634 * medfilt_u - 1.72043 * medfilt_v) .* maskR;
    R_B = (0.99998 * R_R + 2.03212 * medfilt_u - 1.13983 * medfilt_v) .* maskR;
    
    % Green: Solve for R, B
    % {{R -> 0.999996 G + 0.394633 U + 1.72043 V, 
    %B -> 0.999976 G + 2.42675 U + 0.580565 V}}
    G_G = maskedG;
    
    G_R = (0.999996 * G_G + 0.394633 * medfilt_u + 1.72043 * medfilt_v) .* maskG;
    G_B = (0.999976 * G_G + 2.42675 * medfilt_u + 0.580565 * medfilt_v) .* maskG;
    
    % Blue: Solve for R, G
    % {{R -> 1.00002 B - 2.03217 U + 1.13985 V, 
    % G -> 1.00002 B - 2.42681 U - 0.580579 V}}
    B_B = maskedB;
    
    B_R = (1.00002 * B_B - 2.03217 * medfilt_u + 1.13985 * medfilt_v) .* maskB;
    B_G = (1.00002 * B_B - 2.42681 * medfilt_u - 0.580579 * medfilt_v) .* maskB;
    
    % Compose final image
    out = zeros([size(img) 3]);
    out(:,:,1) = R_R + G_R + B_R;
    out(:,:,2) = R_G + G_G + B_G;
    out(:,:,3) = R_B + G_B + B_B;
    
    
    
    