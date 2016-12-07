function [ata, atb] = normal_equations_conversion(a, b)
  % for ax = b
  assert(ismatrix(a));
  assert(iscolumn(b));
  ata = a' * a;
  atb = a' * b;