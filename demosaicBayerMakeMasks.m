function [maskR, maskG, maskB] = demosaicBayerMakeMasks(sz)
    assert(isrow(sz) && length(sz) == 2);
    
    maskR = zeros(sz);
    maskG = maskR;
    maskB = maskR;
    
    maskR(1:2:end, 1:2:end) = 1;
    
    maskG(2:2:end, 1:2:end) = 1;
    maskG(1:2:end, 2:2:end) = 1;
    
    maskB(2:2:end, 2:2:end) = 1;