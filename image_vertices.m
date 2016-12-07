function o = image_vertices(i)
  % returns a 2 x 4 matrix of points
  % [x;y] that are the corners of the image in its own coordinates
  % in clockwise order (in the image coordinate system)
  
  hw = size12(i);
  h = hw(1); w = hw(2);
  
  o = [
  1 w w 1
  1 1 h h
  ];