function s = bounding_box_center_dn(points)
  s = bounding_box_dn(points);
  s = mean(s, 2);