function q = isRowVector(a)
  s = size(a);
  q = (length(s) == 2) && (s(1) == 1);