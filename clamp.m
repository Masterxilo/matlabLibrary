function y = clamp(x, a, b)
  % clamps values in x to the interval [a,b]
  assert(a <= b);
    y = min(max(x, a), b);