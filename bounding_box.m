function aabb = bounding_box(p)
    % given an n x d matrix of d-dimensional points,
    % returns a 2 x d matrix with the axis-aligned bounding box of the
    % points, with the lesser coordinate in the first row
    assert(ismatrix(p))
    aabb = minmax2(p);