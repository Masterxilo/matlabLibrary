function l = allX(x)
  l = all(x);  
  while ~isscalar(l)
    l = all(l);
  end