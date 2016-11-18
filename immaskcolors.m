function mcolors = immaskcolors(img, mask)
  % given a binary mask, create 3 x n array of colors taken from the color
  % image by selecting all those pixels where mask is 1
  %
  % Code from Computational Photography exercise 4, P7047, hs2016
  %
  assert_same_size12(img,mask)
  
  % get all pixel colors in a 3 x (#pixels) array
  colors = reshape(shiftdim(img,2), 3, size(img,1)*size(img,2));
  % get all pixel coordinates in a 2 x (#pixels) array
  x = zeros(size(img,1),size(img,2),2);
  [x(:,:,1) x(:,:,2)] = meshgrid(1:size(img,2),1:size(img,1));
  x = reshape(shiftdim(x,2),2,size(img,1)*size(img,2));
  % get the mask in a 1 x (#pixels) array
  amask = reshape(mask,1,size(img,1)*size(img,2));
  % get the indices of the foreground and background pixels
  [~, ~, mindices] = intersect(x', (x.*[amask; amask])', 'rows');
  % extract only masked pixels
  mcolors = colors(:,mindices);
  
  assert(size(mcolors,1) == 3);