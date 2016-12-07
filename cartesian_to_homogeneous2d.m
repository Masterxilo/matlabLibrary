function out = cartesian_to_homogeneous2d(xy)
    % xy is 2xn list of points
    % out is 3xn list of points with 1 attached
    assert(size(xy, 1) == 2);
    assert(isreal(xy));
    
    n = size(xy,2);
    out = [xy;repmat(1,1,n)];