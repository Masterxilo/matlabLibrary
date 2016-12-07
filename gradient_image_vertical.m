function i = gradient_image_vertical(hw)
  % creates a matrix of hw(2) copies of the column vector 1:hw(1)
  i = repmat((1:hw(1))', 1, hw(2));