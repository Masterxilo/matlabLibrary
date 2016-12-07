function vl_plotframe_yk(f)
  % f comes from vl_sift
  % plot descriptors in black and yellow for better contrast
  % plots in current figure
  h1 = vl_plotframe(f) ;
  h2 = vl_plotframe(f) ;
  set(h1,'color','k','linewidth',3) ;
  set(h2,'color','y','linewidth',2) ;