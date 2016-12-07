function r = bounding_box_to_rectangle(aabb)
    % returns [x,y,w,h] suitable for passing to the rectangle() function
    % aabb comes from bounding_box for 2d point list: 
    % the first row contains the minimum point, the second the maximum
    assert(size(aabb,1) == 2);
    assert(size(aabb,2) == 2);

    r = [aabb(1,:), (aabb(2,:)-aabb(1,:))+1];
    