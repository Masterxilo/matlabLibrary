function o = boundary_distance_mask_manhattan2(hw)
  % pointwise-squared output of boundary_distance_mask_manhattan
  %
  % this is a good mask for image blending
  o = boundary_distance_mask_manhattan(hw);
  o = o .* o;