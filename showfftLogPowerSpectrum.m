function showfftLogPowerSpectrum(ft)
    % Takes a non-centered 2d fourier transform (fft2 result)
    % centers and visualizes its power spectrum
    % in the current figure
    ftc = fftshift(ft);
    imshow(rescale01(log(1 + ftc .* conj(ftc))))