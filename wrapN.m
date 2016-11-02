function y = wrapN(x, n)
    % same as mod(x, n), but for 1-based indices, returning numbers
    % between 1 and n according to circular indexing
    % x can be a vector
    % wrapN(0, 20) == 20
    y = (1 + mod(x-1, n));