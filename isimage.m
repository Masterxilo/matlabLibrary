function q = isimage(img)
    % an image is a matrix or a tensor height x width x channels
    q = length(size(img)) == 2 || length(size(img)) == 3;