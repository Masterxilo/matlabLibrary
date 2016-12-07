function B = rescale01(A)
    % linearly scales and shifts values in A to lie in the range [0,1]
    % if all values are exactly the same, they are set to 0 
    %
    % (other
    % extensions to this special case would be possible, e.g. being
    % undefined/implementation-defined behaviour [which this implementation satisfies])
    %%
    minv = min(A(:));
    maxv = max(A(:));
    if minv == maxv
        B = zeros(size(A));
    else
        B = (A - minv) / (maxv - minv);
    end