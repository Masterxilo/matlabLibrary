function [mask] = imread_logical(filename)
 % '../images/chrome/chrome.mask.png'
 % assume black and white image, read as 0 or 1 (round)
  maskFull = imreaddouble_grayscale(filename);
  mask = logical(round(maskFull));