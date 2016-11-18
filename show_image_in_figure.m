function hf = show_image_in_figure(image, titleName) 
  % creates a new figure and imshow s the image in it
  % finally retruning the handle to the figure
  hf = figure();figure_reset(hf);
  hf.Name = titleName;  
  ha = axes();
  imshow(image, 'Parent', ha);
  title(ha, titleName);