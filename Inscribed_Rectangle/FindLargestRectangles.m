function [C, H, W, M] = FindLargestRectangles(I, crit, minSize)
  % Inputs and outputs as for FindLargestRectanglesSub
  %         M    - Mask the largest all-white rectangle of the image
  if (nargin<2)
  crit = [1 1 0];
end
if (nargin<3)
  minSize = [1 1];
end
  [C, H, W, r, c] = FindLargestRectanglesSub(I, crit, minSize)
  
  M = false(size(C));
  M( r:(r+H(r,c)-1), c:(c+W(r,c)-1) ) = 1;
