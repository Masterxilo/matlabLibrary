function o = immask(image, mask)
    % multiplies each channel in image with mask
    % the mask does not have to be logical
    
    c = size(image,3);
    o = image;
    for i=1:c
        o(:,:,i) = mask(:,:) .* image(:,:,i);
    end
    