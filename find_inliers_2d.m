function f = find_inliers_2d(p1, p2, dist_threshold)
    % c.f. mask_inliers_2d
    f = find(mask_inliers_2d(p1, p2, dist_threshold))