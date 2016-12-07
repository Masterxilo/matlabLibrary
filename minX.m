function l = minX(x)
  l = min(x);  
  while ~isscalar(l)
    l = min(l);
  end