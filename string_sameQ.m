function q = string_sameQ(a, b)
  assert(isstring(a));
  assert(isstring(b));
  
  if ~same_size(a, b)
    q = 0; return;
  end
  
  q = all(a == b);