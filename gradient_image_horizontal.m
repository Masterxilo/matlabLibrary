function i = gradient_image_horizontal(hw)
  % creates a matrix of hw(1) copies of the row vector 1:hw(2)
  i = gradient_image_vertical(reverse(hw))';