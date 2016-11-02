function y = clamp(x, a, b)
    assert(a <= b);
    y = min(max(x, a), b);