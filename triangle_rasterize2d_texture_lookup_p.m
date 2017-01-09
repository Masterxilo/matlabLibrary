function lookup_points = triangle_rasterize2d_texture_lookup_p(points_in_triangle, vertices, texture_vertices)
  % subfunction of triangle_rasterize2d_texture_lookup
  
  
  % Transformation for looking up colors for points_in_triangle in
  % texture

  % set up of transformation
  homvertices = [vertices'; 1 1 1];
  homtexture_vertices = [texture_vertices'; 1 1 1]; % not vertices
  vertices_to_texture = homtexture_vertices * inv(homvertices);

  % apply 
  lookup_points = vertices_to_texture * cartesian_to_homogeneous2d(points_in_triangle);
  %assert()
  assert(size(lookup_points, 1) == 3);
  lookup_points = lookup_points([1 2], :); % discard homogeneous 1

  %figure();scatter2(lookup_points); title('lookup points')