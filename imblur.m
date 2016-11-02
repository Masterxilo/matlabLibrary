function out = imblur(varargin) % A, sigma == 2)
    assert(nargin > 0);
    A = varargin{1};
    if nargin == 1
        sigma = 2;
    else
        sigma = varargin{2};
    end

    out = imgaussfilt(A,sigma);