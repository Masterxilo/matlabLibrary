function o = coordinates_list_2n(xminmax, yminmax)
    % determines all integral (x,y) coordinates within the given bounds
    % o: 2xn list of coordinates
    %
    % y coordinates increase first (columnwise)
    
    assert(length(xminmax) == 2);
    assert(length(yminmax) == 2);
    
    [X,Y] = meshgrid(xminmax(1):xminmax(2), yminmax(1):yminmax(2));
    c(1,:,:) = X;
    c(2,:,:) = Y;
    
    o = reshape(c, 2, numel(X));