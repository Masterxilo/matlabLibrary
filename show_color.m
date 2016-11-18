function show_color(rgb)
  % shows an RGB color in the current figure or subfigure
  rectangle('Position',[0,0,1,1],'FaceColor',rgb(:));
  set(gca(),'xtick',[],'ytick',[]);