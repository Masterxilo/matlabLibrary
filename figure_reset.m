function figure_reset(hf)
  reset(hf);
  set(hf, 'Position', get(0,'defaultfigureposition')); % otherwise, the last size of this figure will be used, even if it was closed
 