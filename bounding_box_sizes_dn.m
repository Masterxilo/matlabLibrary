function s = bounding_box_sizes_dn(points)
  s = bounding_box_dn(points);
  s = s(:,2) - s(:,1);