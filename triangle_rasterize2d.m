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
    
    channels = size(texture, 3);
    
    [mask, points_in_triangle] = triangle_rasterize2d_mask(vertices, output_size);
    assert(size(points_in_triangle, 1) == 2);
    n = size(points_in_triangle, 2);
    
    
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
    
    % lookup
    colors = bilinear_interpolate_multiple(texture, lookup_points);
    assert(size(colors,1) == channels);
    assert(size(colors,2) == n);
    
    % pasting in the right places
    flat_pixels = zeros(output_size(1) * output_size(2), channels);
    
    points_in_trianglei = sub2ind(output_size, points_in_triangle(2,:), points_in_triangle(1,:));
    
    flat_pixels(points_in_trianglei, :) = colors';
    
    pixels = reshape(flat_pixels, output_size(1), output_size(2), channels);
    
    
    