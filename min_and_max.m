function min_max = min_and_max(A)
    % flattens A, then returns the minimum and maximum of its elements
    % in a list of two elements
    B = A(:);
    min_max = [min(B) max(B)];