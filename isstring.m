function q = isstring(x)
  c1 = class(x);
  c2 = 'char';
  
  if ~same_size(c1, c2)
    q = 0; return;
  end
  
  q = all(c1 == c2) && size(x,1) == 1;