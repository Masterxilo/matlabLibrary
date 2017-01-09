function [mask, points_in_triangle] = triangle_rasterize2d_mask(vertices, output_size)
    % 
    % The triangle is rendered into a binary mask of output_size,
    % points_in_triangle is 2xn containing all points (x,y) that lie within the
    % triangle.
    %
    % vertices is 3x2, with each row containing the 2d coordinates of a
    % triangle vertex.
    
    % Implementation: this is quite similar to what happens in rasterizeExample2.m
    
    [aabbi, out_within_aabb, points_in_triangle] = triangle_rasterize2d_points(vertices);
    
    mask = zeros(output_size);
    mask(aabbi(1,2):aabbi(2,2), aabbi(1,1):aabbi(2,1)) = out_within_aabb;
    mask = mask == 1;

    