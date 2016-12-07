function x = clamp01(y)
    % clamps all values in x to be within [0,1]
    x = max(0, min(1, y));