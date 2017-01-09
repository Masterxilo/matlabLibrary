function showfftPowerSpectrum(ft)
    % Takes a non-centered 2d fourier transform (fft2 result)
    % centers and visualizes its power spectrum
    % using imshow in the current figure [implementation
    % detail/visualization function (meta computation)...]
    %
    % Most likely, you will see nothing with this. Prefer
    % showfftLogPowerSpectrum.
    ftc = fftshift(ft);
    imshow(rescale01(ftc .* conj(ftc)))