function CP06_show_horizontal_epi(lf, y)
  fimage = uint16toUnorm(squeeze(lf(8,8,:,:,1:3)));
  
  s = CP06_lf_extract_horizontal_epi(lf, y);

  imshow_in_figure(s, 'EPI');

  s = imresize(s, [size(s,1)*5 size(s,2)]);
  imshow_in_figure(rescale01(s), 'linearly rescaled for better contrast, resized');

  imshow_in_figure(fimage, 'EPI extracted line visualization');
  hold on; % hold on, baby
  line([1 size(lf,4)], [y y],'Color', 'r');