function aabbi = bounding_box_int_overestimate(points)
    % like bounding box, but floors the min and ceils the max,
    % giving an integral overestimate for the aabb
    
    aabb = bounding_box(points);
    aabbi = [floor(aabb(1,:));ceil(aabb(2,:))];