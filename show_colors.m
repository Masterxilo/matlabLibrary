function hf = show_colors(colors, titleName)
  % in a new figure, using subplot and show_color, shows all rgb
  % colors given in colors, a 3 x n array (as returned by say immaskcolors)
  
  
  hf = figure('Name', titleName); figure_reset(hf);  
  
  m = 1;
  n = size(colors,2);
  assert(size(colors,1) == 3);
  for i=1:n
    subplot(m,n,i);
    show_color(colors(:,i));
  end
  
  mtit(hf, titleName);