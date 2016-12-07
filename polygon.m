function polygon(p)
  % p is n x 2
  % similar to calling plot with the first point repeated
  % aka. closed_path2d
  
  assert(isreal(p));
  assert(ismatrix(p));
  assert(size(p,2) == 2);
  
  
  line(p(:,1),p(:,2))
  back = [size(p,1) 1];
  line(p(back,1),p(back,2))