function prod = arrayVolume(array)
    % gives the product of the elements of size(array), which is 
    % - the length of a row or column vector
    % - the 'area' of a matrix/image (at least for grayscale)
    % - the total amount of elements in the array
    % - length(array(:))
    %
    % same effect as numel
    prod = arrayProduct(size(array));