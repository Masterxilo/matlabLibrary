function result_image = mesh_textured_2d_impl3(vertices, texture_vertices, triangles, texture, output_size)
  % faster implementation?
  % similar to mesh_textured_2d_impl2, but computes 
  % -all- points first, then looks them up in the texture
  %
  % in my tests, this was slower than test_mesh_textured_2d_impl2
  
  n = size(vertices, 1);
  assert_in_range(vertices(:,2), 1, output_size(1)); % y
  assert_in_range(vertices(:,1), 1, output_size(2)); % x

  assert(ismatrix(texture_vertices));
  assert(size(texture_vertices,2) == 2);
  assert(n == size(texture_vertices, 1));
  assert_in_range(texture_vertices(:,2), 1, size(texture, 1)); % y
  assert_in_range(texture_vertices(:,1), 1, size(texture, 2)); % x

  assert(ismatrix(triangles));
  assert_equal(triangles, floor(triangles));
  assert(size(triangles,2) == 3);
  m = size(triangles, 1);

  assert(length(output_size) == 2);

  % rasterize all triangles into all_points_in_triangles
  % and all texture lookup points into all_lookup_points
  
  % there are at most as many as there are output pixels
  k = arrayProduct(output_size);
  all_points_in_triangles = zeros(2,k);
  all_lookup_points = zeros(2,k);
  
  l = 1;
  
  for i=1:m
     % draw triangle i
     trianglei_vertices = vertices(triangles(i,:),:);
     trianglei_texture_vertices = texture_vertices(triangles(i,:),:);
     
     [~, ~, points_in_triangle] = triangle_rasterize2d_points(trianglei_vertices);
     
     u = size(points_in_triangle,2);
    
     %lookup_points = 
     all_lookup_points(:,l:l+u-1) = triangle_rasterize2d_texture_lookup_p(points_in_triangle, trianglei_vertices, trianglei_texture_vertices);

     u = size(points_in_triangle,2);
     %assert(u == size(lookup_points,2));
     %assert(2 == size(lookup_points,1));
     assert(2 == size(points_in_triangle,1));
     
     all_points_in_triangles(:,l:l+u-1) = points_in_triangle;
     %all_lookup_points(:,l:l+u-1) = lookup_points;
      
     l = l + u;
  end
  
  assert(l-1 <= k); % valid points are 1:l-1
  
  % Texturing

  % preflatten texture for lookup
  dim = size12(texture);
  channels = size(texture,3);
  flat_texture = reshape(shiftdim(texture,2), channels, arrayProduct(dim)); % list of colors, accessing texture via sub2ind(dim, x) style indices

  % assume 3 channels
  assert(channels == 3);
  result_image_r = zeros([output_size]);
  result_image_g = zeros([output_size]); 
  result_image_b = zeros([output_size]); 

  colors = bilinear_interpolate_multiple_flat_nb(flat_texture, dim, channels, all_lookup_points(:,1:l-1));  % lookup
  %colors = bilinear_interpolate_multiple_flat_nb2(flat_texture, dim, channels, all_lookup_points(:,1:l-1)');  % lookup

  
  assert(size(colors,1) == 3);
  assert(size(colors,2) == l-1);

  % pasting in the right places
  points_in_trianglei = sub2ind(output_size, all_points_in_triangles(2,1:l-1), all_points_in_triangles(1,1:l-1));
  assert(isvector(points_in_trianglei));

  result_image_r(points_in_trianglei) = colors(1,:);
  result_image_g(points_in_trianglei) = colors(2,:);
  result_image_b(points_in_trianglei) = colors(3,:);

  result_image = zeros([output_size, channels]);
  result_image(:,:,1) = result_image_r;
  result_image(:,:,2) = result_image_g;
  result_image(:,:,3) = result_image_b;