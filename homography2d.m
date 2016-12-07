function H = homography2d(p, q)
    % find the homography, i.e. 3x3 homogeneous matrix
    % that transforms points p to q (after homogeneous division)
    % This is uniquely defined for four points (?), overdetermined for more
    % (in which case the leastsquares solution is given) and
    % underdetermined for less (in which case any solution is given)
    %
    % p: 2xn
    % q: 2xn
    
    assert(isreal(q) && isreal(p));
    assert(size(p,1) == 2);
    assert(size(q,1) == 2);
    n = size(p,2);
    assert(size(q,2) == n);
    
    H = homography2d_impl2(p, q);