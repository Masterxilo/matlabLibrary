function CP06_3_2_show_spatial_blur(lffc, slope, spatial_std_scale)
  % spatial_std_scale stretches epirically determined values to show they
  % are an ok choice
  
  spatsz = 8 * spatial_std_scale;
  final = CP06_make_final_filter( 7, 0.5 * spatial_std_scale, 2, 2.5 * spatial_std_scale, spatsz, slope); 
  
  imshow_in_figure(2*squeeze( convn(lffc, normalize_integral(final), 'valid') ), ...
  ['showing slope ' num2str(slope) ' with spatial blur factor ' num2str(spatial_std_scale)] );