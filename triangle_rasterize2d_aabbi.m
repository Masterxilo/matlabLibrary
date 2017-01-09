function [aabbi, out_within_aabb, tested_points, tested_points_inQ] = triangle_rasterize2d_aabbi(vertices)
    % subfunction of triangle_rasterize2d_mask returning the aabb extended
    % to integers and the reshaped tested points as well as other
    % intermediates
    %
    % this is useful for rendering into a larger buffer all at once, see
    % triangle_rasterize2d_impl2
    
    % Implementation: this is quite similar to what happens in rasterizeExample2.m
    assert(size(vertices,1) == 3);
    aabbi = bounding_box_int_overestimate(vertices);
    xywh = bounding_box_to_rectangle(aabbi);
    
    tested_points = coordinates_list_2n([aabbi(1,1) aabbi(2,1)],[aabbi(1,2) aabbi(2,2)]);
    tested_points_inQ = rasterize(vertices', tested_points);
    
    out_within_aabb = reshape(tested_points_inQ, xywh(4), xywh(3));