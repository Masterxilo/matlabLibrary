function [mi, ma] = min_and_max2(A)
    % flattens A, then returns the minimum and maximum of it
    B = A(:);
    mi = min(B); ma = max(B);