function [mask, points_in_triangle] = triangle_rasterize2d_mask(vertices, output_size)
    % vertices is 3x2, with each row containing the 2d coordinates of a
    % triangle vertex.
    %
    % 
    % The triangle is rendered into a binary mask of output_size,
    % points_in_triangle is 2xn containing all points (x,y) that lie within the
    % triangle.
    
    % Implementation: this is quite similar to what happens in rasterizeExample2.m
    aabbi = bounding_box_int_overestimate(vertices);
    xywh = bounding_box_to_rectangle(aabbi);
    
    tested_points = coordinates_list_2n([aabbi(1,1) aabbi(2,1)],[aabbi(1,2) aabbi(2,2)]);
    tested_points_inQ = rasterize(vertices', tested_points);
    points_in_triangle = tested_points(:, tested_points_inQ == 1);
    
    out_within_aabb = reshape(tested_points_inQ, xywh(4), xywh(3));
    
    mask = zeros(output_size);
    mask(aabbi(1,2):aabbi(2,2), aabbi(1,1):aabbi(2,1)) = out_within_aabb;
    mask = mask == 1;

    