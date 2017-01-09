function result_image = mesh_textured_2d_impl2(vertices, texture_vertices, triangles, texture, output_size)
  % fast implementation
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

  mask_only = false; % set to true to debug pure pixels covered - note that  test_mesh_textured2d_impl2 does not cope with this
  if mask_only
    channels = 1;
  else
    channels = size(texture, 3); % set to 1 for mask only
    
    % assume 3 channels
    assert(channels == 3);
    result_image_r = zeros([output_size]);
    result_image_g = zeros([output_size]); 
    result_image_b = zeros([output_size]); 
  
  end
  
  result_image = zeros([output_size, channels]);
  
  % preflatten texture for lookup
  dim = size12(texture);
  channels = size(texture,3);
  flat_texture = reshape(shiftdim(texture,2), channels, arrayProduct(dim)); % list of colors, accessing texture via sub2ind(dim, x) style indices
  
  % rasterize all triangles into result_image directly
  for i=1:m
     % draw triangle i
     trianglei_vertices = vertices(triangles(i,:),:);
     trianglei_texture_vertices = texture_vertices(triangles(i,:),:);
     
     % rasterize directly into result_image
     
     [aabbi, out_within_aabb, points_in_triangle] = triangle_rasterize2d_points(trianglei_vertices);
    
     % Without points_in_triangle:
     %[aabbi, out_within_aabb, tested_points, tested_points_inQ] = triangle_rasterize2d_aabbi(trianglei_vertices);
     
     % rasterizing mask only
     if mask_only
       result_image(aabbi(1,2):aabbi(2,2), aabbi(1,1):aabbi(2,1)) = ...
         result_image(aabbi(1,2):aabbi(2,2), aabbi(1,1):aabbi(2,1)) + ...
         out_within_aabb;
     else
        % Texture lookup
        % colors = triangle_rasterize2d_texture_lookup(points_in_triangle, trianglei_vertices, trianglei_texture_vertices, texture);

        % more efficient (preflattened)

        lookup_points = triangle_rasterize2d_texture_lookup_p(points_in_triangle, trianglei_vertices, trianglei_texture_vertices);

        colors = bilinear_interpolate_multiple_flat(flat_texture, dim, channels, lookup_points);  % lookup

        assert(size(colors,1) == 3);
        assert(size(colors,2) == size(points_in_triangle,2));

        % pasting in the right places
        points_in_trianglei = sub2ind(output_size, points_in_triangle(2,:), points_in_triangle(1,:));
        assert(isvector(points_in_trianglei));
        
        result_image_r(points_in_trianglei) = colors(1,:);
        result_image_g(points_in_trianglei) = colors(2,:);
        result_image_b(points_in_trianglei) = colors(3,:);
     end
  end
  
  if ~mask_only
    result_image(:,:,1) = result_image_r;
    result_image(:,:,2) = result_image_g;
    result_image(:,:,3) = result_image_b;
  end