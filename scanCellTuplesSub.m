function scanCellTuplesSub(f, x, xs)
    % Assumes x is a cell array of length less than or equal to the length
    % of xs and that xs(1:k) for k := length(xs) contains elements from
    % x{1:k}
    %
    % Calls f on xs if k == length(x)
    % otherwise calls scanCellTuplesSub on each [xs y] for y in x{k+1}
    %
    % This effectively calls f on each tuple of values from the cell array.
    %
    % Try scanCellTuplesSub(@disp, {1:2, 4:5}, [])
    
    k = length(xs);
    assert(length(x) >= k);
    if length(x) == k
        f(xs);
    else
        for y = x{k+1}
            scanCellTuplesSub(f, x, [xs y]);
        end
    end