function y = wrapNMultiple(x, n)
    % same as wrapN but for vectors x and n
    % wrapNMultiple([0,10],[20,3]) == [20     1]
    assert(length(x) == length(n));
    y = arrayfun(@(i) wrapN(x(i), n(i)), 1:length(n));