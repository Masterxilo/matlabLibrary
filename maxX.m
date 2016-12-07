function l = maxX(x)
  % overall max
  % equivalent to max(x(:))
  l = max(x);  
  while ~isscalar(l)
    l = max(l);
  end