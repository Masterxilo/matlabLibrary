function B = circularMatrixAccess(A, varargin)
    % gives A(rows, cols, ...), where all indices are first wrapped circularly
    % using wrapN to fall within the matrix
    %
    % many applications of this can use imfilter(..., 'circular') instead
    
    nVarargs = length(varargin);
    assert(nVarargs == length(size(A)));
    n = size(A);
    
    x = cell(nVarargs, 1);
    for k = 1:nVarargs
    	x{k} = wrapN(varargin{k}, n(k));
    end   
    
    B = cellArrayAccess(A, x);