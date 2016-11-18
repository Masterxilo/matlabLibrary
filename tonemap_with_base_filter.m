function out = tonemap_with_base_filter(in, output_range, base_filter)
    % Tonemapping with any base-layer filter
    %
    % - in is a color image
    % - output_range scales the brightness of the resulting image
    % - base_filter takes an image and computes its base scale, i.e. removes
    % details
    %
    
    assert(isscalar(output_range));
    assert(isimage(in));
    assert(isfunction_handle(base_filter));
    
    R = in(:,:,1);
    G = in(:,:,2);
    B = in(:,:,3);
    
    input_intensity = 1/61*(R*20+G*40+B);
    log_base = base_filter(log(input_intensity));
    log_detail = log(input_intensity) - log_base;
    compressionfactor = log(output_range)/(max(max(log_base))-min(min(log_base)));
    log_offset = -max(max(log_base)) * compressionfactor;
    log_output_intensity = log_base * compressionfactor + log_offset + log_detail;
    
    output_intensity = exp(log_output_intensity);
    
    out = in; % for dimensions % ideally this would not create a copy, but I guess it does in matlab
    out(:,:,1) = R ./ input_intensity .* output_intensity;
    out(:,:,2) = G ./ input_intensity .* output_intensity;
    out(:,:,3) = B ./ input_intensity .* output_intensity;