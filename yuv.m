function [y,u,v] = yuv(img)
% Returns y u and v channel of rgb2yuv converted image separately
    % img is of size [m n 3], and is interpreted as rgb
    % With colors in [0,1]
    assert(isimage(img));
    assert(isdouble(img));
    assert(size(img,3) == 3);
    
    yuv_ = yuvAll(img);
    y = yuv_(:,:,1);
    u = yuv_(:,:,2);
    v = yuv_(:,:,3);