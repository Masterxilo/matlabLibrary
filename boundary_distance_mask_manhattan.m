function i = boundary_distance_mask_manhattan(hw)
  % creates an image where each pixel specifies the shortest manhattan
  % distance to the boundary
  
  a0 = gradient_image_horizontal(hw);
  a1 = gradient_image_horizontal_flipped(hw);
  a2 = gradient_image_vertical(hw);
  a3 = gradient_image_vertical_flipped(hw);
  
  i = min(min(min(a0, a1), a2), a3);
  