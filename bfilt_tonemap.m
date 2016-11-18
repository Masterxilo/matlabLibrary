function out = bfilt_tonemap(in, output_range, varargin)
    % Tone mapping using bilateral filtering to compute the base scale
    % see tonemap_with_base_filter
    %
    % Inputs:
    % - in: input floating point rgb hdr image
    % - output_range: amount of remaining large-scale contrast that you want in the output. A value of 10 to 30 works well.
    % - varargin: sigma_s, sigma_r for bilateral filter
    %   if sigma_r is very large, this tonemapping strategy does the same
    %   as gauss_tonemap
    %
    
    if length(varargin) >= 1
        sigma_s = varargin{1};
    else
        sigma_s = 2;
    end
    
    if length(varargin) >= 2
    	sigma_r = varargin{2};
    else
        sigma_r = 0.12;
    end
    
    assert(sigma_s > 0 && sigma_r > 0);
    bilateral = @(im) bfilt(im, sigma_s, sigma_r);
    
    % Tone mapping using bilateral filtering
    out = tonemap_with_base_filter(in, output_range, bilateral);
    