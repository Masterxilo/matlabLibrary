function triplot2(tri, points_n2, varargin)
  assert(size(points_n2, 2) == 2);
  
  triplot(tri, points_n2(:,1), points_n2(:,2), varargin{:});
  
