function r = image_data_range(image)
  % returns [1 width 1 heigth], suitable for axes range
  r = [1 size(image,2) 1 size(image,1)];