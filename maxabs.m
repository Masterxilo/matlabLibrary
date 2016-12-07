function d = maxabs(x)
  % returns a single scalar that is the largest absolute value in the array
  % x
  d = abs(x);
  d = max(d(:));