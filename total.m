
function t = total(m)
    % total over all matrix entries
    % aka sumX
    dims = length(size(m));
    t = m;
    for i=1:dims
        t = sum(t);
    end