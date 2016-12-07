function scatter2(xy, varargin)
    % scatter for 2xn list of points (x,y)
    % same options as scatter()
    assert(size(xy, 1) == 2);
    assert(ismatrix(xy));
    
    scatter(xy(1,:), xy(2,:), varargin{:})