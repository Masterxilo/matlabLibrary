function y = normalize_integral(x)
  % rescale x by a single number such that
  % sumX(x) == 1
  %
  % This does not shift the data (unlike rescale01).
  % rescale1 has a different effect but also applies a single scale factor
  % to all of the data.
  
  s = sumX(x);
  assert(s ~= 0);
  y = x / s;