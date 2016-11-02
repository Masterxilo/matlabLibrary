function B = rescale01(A)
    % linearly scales and shifts values in A to lie in the range [0,1]
    minv = min(A(:));
    maxv = max(A(:));
    if minv == maxv
        B = A
    else
        B = (A - minv) / (maxv - minv);
    end