function result_image = mesh_textured_2d_impl1(vertices, texture_vertices, triangles, texture, output_size)
  % reference implementation using the whole hierarchy of functions built
  % for solving this exercise.
  %
  % slower than impl2
  assert(ismatrix(vertices));
  assert(size(vertices,2) == 2);
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

  channels = size(texture,3);

  result_image = zeros([output_size, channels]);
  for i=1:m
     % draw triangle i
     %triangles(i,:)
     [trianglei_pixels, ~, ~] = triangle_rasterize2d(vertices(triangles(i,:),:), texture_vertices(triangles(i,:),:), texture, output_size);

     %imshow_in_figure(trianglei_pixels, num2str(i)); % debug individual
     %triangle

     result_image = result_image + trianglei_pixels; % assumes no overlaps
  end