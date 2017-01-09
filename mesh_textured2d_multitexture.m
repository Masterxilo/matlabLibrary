function [result_image1, result_image2] = mesh_textured2d_multitexture(vertices, triangles, texture_vertices1, texture1, texture_vertices2, texture2, output_size)
    % same as mesh_textured2d
    % (with mesh_textured_2d_impl2)
    % but computes the result for two different sets of texture vertices
    % and textures at once
    
    % from mesh_textured_2d_impl2:
    % fast implementation
  n = size(vertices, 1);
  assert_in_range(vertices(:,2), 1, output_size(1)); % y
  assert_in_range(vertices(:,1), 1, output_size(2)); % x

  assert(ismatrix(texture_vertices1));
  assert(size(texture_vertices1,2) == 2);
  assert(n == size(texture_vertices1, 1));
  assert_in_range(texture_vertices1(:,2), 1, size(texture1, 1)); % y
  assert_in_range(texture_vertices1(:,1), 1, size(texture1, 2)); % x
  
  assert(ismatrix(texture_vertices2));
  assert(size(texture_vertices2,2) == 2);
  assert(n == size(texture_vertices2, 1));
  assert_in_range(texture_vertices2(:,2), 1, size(texture2, 1)); % y
  assert_in_range(texture_vertices2(:,1), 1, size(texture2, 2)); % x


  assert(ismatrix(triangles));
  assert_equal(triangles, floor(triangles));
  assert(size(triangles,2) == 3);
  m = size(triangles, 1);

  assert(length(output_size) == 2);

  
  channels = size(texture1, 3); % set to 1 for mask only

  % assume 3 channels
  assert(channels == 3);
  assert(channels == size(texture2, 3));
  result_image_r1 = zeros([output_size]);
  result_image_g1 = zeros([output_size]); 
  result_image_b1 = zeros([output_size]); 
  
  result_image_r2 = zeros([output_size]);
  result_image_g2 = zeros([output_size]); 
  result_image_b2 = zeros([output_size]); 

  
  % preflatten texture for lookup
  dim1 = size12(texture1);
  flat_texture1 = reshape(shiftdim(texture1,2), channels, arrayProduct(dim1)); % list of colors, accessing texture via sub2ind(dim, x) style indices
  
  dim2 = size12(texture2);
  flat_texture2 = reshape(shiftdim(texture2,2), channels, arrayProduct(dim2)); % list of colors, accessing texture via sub2ind(dim, x) style indices
  
  % rasterize all triangles into result_image directly
  for i=1:m
     % draw triangle i
     trianglei_vertices = vertices(triangles(i,:),:);
     
     [~, ~, points_in_triangle] = triangle_rasterize2d_points(trianglei_vertices);
    
      % Texture lookup 1
     trianglei_texture_vertices = texture_vertices1(triangles(i,:),:);
      lookup_points = triangle_rasterize2d_texture_lookup_p(points_in_triangle, trianglei_vertices, trianglei_texture_vertices);

      colors = bilinear_interpolate_multiple_flat(flat_texture1, dim1, channels, lookup_points);  % lookup

      assert(size(colors,1) == 3);
      assert(size(colors,2) == size(points_in_triangle,2));

      points_in_trianglei = sub2ind(output_size, points_in_triangle(2,:), points_in_triangle(1,:));
      assert(isvector(points_in_trianglei));

      result_image_r1(points_in_trianglei) = colors(1,:);
      result_image_g1(points_in_trianglei) = colors(2,:);
      result_image_b1(points_in_trianglei) = colors(3,:);
      
      
      % Texture lookup 2
     trianglei_texture_vertices = texture_vertices2(triangles(i,:),:);
      lookup_points = triangle_rasterize2d_texture_lookup_p(points_in_triangle, trianglei_vertices, trianglei_texture_vertices);

      colors = bilinear_interpolate_multiple_flat(flat_texture2, dim2, channels, lookup_points);  % lookup

      assert(size(colors,1) == 3);
      assert(size(colors,2) == size(points_in_triangle,2));

      points_in_trianglei = sub2ind(output_size, points_in_triangle(2,:), points_in_triangle(1,:));
      assert(isvector(points_in_trianglei));

      result_image_r2(points_in_trianglei) = colors(1,:);
      result_image_g2(points_in_trianglei) = colors(2,:);
      result_image_b2(points_in_trianglei) = colors(3,:);
        
  end
  
  result_image1 = zeros([output_size, channels]);
  result_image2 = zeros([output_size, channels]); 
  
  result_image1(:,:,1) = result_image_r1;
  result_image1(:,:,2) = result_image_g1;
  result_image1(:,:,3) = result_image_b1;
  
  result_image2(:,:,1) = result_image_r2;
  result_image2(:,:,2) = result_image_g2;
  result_image2(:,:,3) = result_image_b2;