function q = isaxis_limits(v)
  % whether v has the form [xmin xmax ymin ymax] 
  q = length(v) == 4 && v(1) <= v(2) && v(3) <= v(4);