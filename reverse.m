function x = reverse(vec)
  % reverses the order of elements in the row or column vector
  assert(isrow(vec) || iscolumn(vec))
  x = flip(vec);