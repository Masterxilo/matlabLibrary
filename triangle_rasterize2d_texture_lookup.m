function colors = triangle_rasterize2d_texture_lookup(points_in_triangle, vertices, texture_vertices, texture)
  % subfunction of triangle_rasterize2d
  % colors will come out channels x n
  
  assert(size(points_in_triangle, 1) == 2);
  n = size(points_in_triangle, 2);

  lookup_points = triangle_rasterize2d_texture_lookup_p(points_in_triangle, vertices, texture_vertices);

  % lookup
  colors = bilinear_interpolate_multiple(texture, lookup_points);
  channels = size(texture, 3);
  assert(size(colors,1) == channels);
  assert(size(colors,2) == n);
    