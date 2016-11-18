function out = gauss_tonemap(in, output_range, sigma)
    % Tone mapping using gaussian filtering to compute the base scale
    % see tonemap_with_base_filter
    assert(isimage(in));
    assert(sigma > 0);
    gaussfilter = @(A) imgaussfilt(A,sigma);

    out = tonemap_with_base_filter(in, output_range, gaussfilter);