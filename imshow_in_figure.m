function hf = imshow_in_figure(im, title)
 % same as show_image_in_figure
 if nargin < 2
   title = 'imshow in figure';
 end
  hf = show_image_in_figure(im, title);