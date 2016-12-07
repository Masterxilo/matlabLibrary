function hf = imshow_in_figure_with_alpha(image, alpha, titleName) 
  % creates a new figure and imshow s the image in it
  % finally retruning the handle to the figure
  hf = figure();figure_reset(hf);
  hf.Name = titleName;  
  ha = axes();
  hi = imshow(image, 'Parent', ha);
  title(ha, titleName);
  hi.AlphaData = alpha;