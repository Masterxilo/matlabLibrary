function [iml, imr] = imreaddouble_halves(fn)
  % reads an image as doubles, computes the left and right half
  i = imreaddouble(fn);
  
  w = imageWidth(i);
  iml = i(:, 1:w/2, :);
  imr = i(:, w/2+1:end, :);