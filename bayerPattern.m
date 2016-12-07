function o = bayerPattern()
    % bayer pattern as 2x2 rgb image used by demosaicBayer
    o(:,:,1) = [1 0;0 0];
    o(:,:,2) = [0 1;1 0];
    o(:,:,3) = [0 0;0 1];