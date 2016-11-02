function q = isColumnVector(a)
  s = size(a);
  q = (length(s) == 2) && (s(2) == 1);