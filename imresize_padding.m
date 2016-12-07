function out = imresize_padding(image, dimensions)
    % resizes the given image to have the indicated 
    % width and height, adding black padding if necessary to preserve
    % the aspect ratio, approximately centering the image in the padded region
    assert(isimage(image));
    assert(isrow(dimensions));
    assert(length(dimensions) == 2);
    
    old_dimensions = size12(image);
    factor = min(dimensions ./ old_dimensions);
    scaled_dimensions = floor(factor * old_dimensions);
    
    assert(minX(image) >= 0);
    assert(maxX(image) <= 1);
    scaled_image = imresize(image, scaled_dimensions, 'bilinear'); % default bicubic can give negative values..., 
    scaled_image = clamp01(scaled_image);% 'bilinear' can still give values slightly > 1... (rounding?) % the
    % range of values is important for im2frame etc.
    assert(minX(scaled_image) >= 0);
    assert(maxX(scaled_image) <= 1);
    
    out = zeros(dimensions(1), dimensions(2), size(image, 3));
    
    lu = floor(max(dimensions/2 - scaled_dimensions/2, [1 1]));
    out(lu(1):lu(1)+scaled_dimensions(1)-1, lu(2):lu(2)+scaled_dimensions(2)-1,:) = scaled_image;
    