function o = single_color_rgb_image(hw,rgb)
  assert(length(rgb) == 3);
  assert(length(hw) == 2);
  
  o = ones([hw(:)' 3]);
  for i=1:3
    o(:,:,i) = o(:,:,i) * rgb(i);
  end