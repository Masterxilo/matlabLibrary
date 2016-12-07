function o = bounding_box_dn(points)
  % takes points in d x n format, returns d x 2 points aa, bb
  o = bounding_box(points')';