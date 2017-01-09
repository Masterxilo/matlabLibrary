function [aabbi, out_within_aabb, points_in_triangle] = triangle_rasterize2d_points(vertices)
    % subfunction of triangle_rasterize2d
    [aabbi, out_within_aabb, tested_points, tested_points_inQ] = triangle_rasterize2d_aabbi(vertices);
    
    points_in_triangle = tested_points(:, tested_points_inQ == 1);