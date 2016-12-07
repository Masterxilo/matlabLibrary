function i = gradient_image_vertical_flipped(hw)
  % creates a matrix of hw(2) copies of the column vector flip(1:hw(1))
  i = repmat(flip((1:hw(1))'), 1, hw(2));