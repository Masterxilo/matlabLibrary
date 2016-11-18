function [rfileSize, l2error] = fftCompressGetFileSizeL2Error(gimage, ratioSetToZero)
    % Compress a 2d signal matrix (e.g. an image)
    % by settting the ratioSetToZero% least power complex amplitudes to 0.
    % Then measure the resulting file size and return the l2error.
    %
    % ratioSetToZero must be between 0 and 1
    %
    % Returns resulting file size and L2 error (use this for creating a table!)
    % Creates a temporary file...
    
    assert(ratioSetToZero >= 0);
    assert(ratioSetToZero <= 1);

    ft = fft2(gimage);
    power = ft .* conj(ft);
    orderedPower = sort(power(:));

    set0Threshold = orderedPower(1 + floor((length(orderedPower)-1)*ratioSetToZero));

    truncatedFt = ft .* (power > set0Threshold);

    save('truncatedFt.mat', 'truncatedFt');
    
    rfileSize = fileSize('truncatedFt.mat');
    gimageRestored = ifft2(truncatedFt);
    l2error = norm(gimage(:) - gimageRestored(:));
