function [pixels, mask, points_in_triangle] = triangle_rasterize2d(vertices, texture_vertices, texture, output_size)
  % Draws a textured 2d triangle.
  %
  % 
  %
  % vertices is 3x2, with each row containing the 2d coordinates of a
  % triangle vertex.
  %
  % texture_vertices is similar.
  %
  % 
  % The triangle is rendered into a mask and image of output_size
  % with each pixel looked up in the texture via bilinear interpolation
  % after doing the affine transformation specified by the 
  % vertices |-> texture_vertices mapping


  [mask, points_in_triangle] = triangle_rasterize2d_mask(vertices, output_size);

  colors = triangle_rasterize2d_texture_lookup(points_in_triangle, vertices, texture_vertices, texture);

  % pasting in the right places

  channels = size(texture, 3);
  points_in_trianglei = sub2ind(output_size, points_in_triangle(2,:), points_in_triangle(1,:));

  flat_pixels = zeros(output_size(1) * output_size(2), channels);
  flat_pixels(points_in_trianglei, :) = colors';

  pixels = reshape(flat_pixels, output_size(1), output_size(2), channels);