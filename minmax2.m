function min_max = minmax2(A)
    % given an n x m matrix,
    % returns a 2 x m matrix of the columnwise min and max
    %
    % Similar to minmax, but operates columnwise
    assert(ismatrix(A))
    min_max = [min(A);max(A) ];