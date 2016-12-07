function [x,y,w,h] = FindLargestRectangle(I, crit, minSize)
  % Inputs as for FindLargestRectanglesSub
  % Returns area-largest rectangle as expected by e.g. rectangle()
  if (nargin<2)
    crit = [1 1 0];
  end
  if (nargin<3)
    minSize = [1 1];
  end

  [C, H, W, r, c] = FindLargestRectanglesSub(I, crit, minSize);
  x = c;
  y = r;
  w = W(r,c);
  h = H(r,c);
