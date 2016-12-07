function r = bounding_box_dn_to_rectangle(aabb)
    % same as bounding_box_to_rectangle, but transposed input as given by
    % bounding_box_2n
    r = bounding_box_to_rectangle(aabb');
    