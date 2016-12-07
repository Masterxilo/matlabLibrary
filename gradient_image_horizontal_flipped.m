function i = gradient_image_horizontal_flipped(hw)
  % creates a matrix of hw(1) copies of the row vector flip(1:hw(2))
  i = gradient_image_vertical_flipped(reverse(hw))';