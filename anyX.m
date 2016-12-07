function l = anyX(x)
  % finds out whether absolutely any entry of the logical array of 
  % any dimension is 1
  l = any(x);  
  while ~isscalar(l)
    l = any(l);
  end