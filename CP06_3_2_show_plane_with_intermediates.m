function CP06_3_2_show_plane_with_intermediates(lffc, slope)
  spatsz = 8;
  
  [final, low_angular_bandwidth, low_spatial_bandwidth, low_spatialxangular_bandwidth, ears] = ...
    CP06_make_final_filter(7, 0.5, 2, 2.5, spatsz, slope); % empirically derived ok-looking values
  
  imshow_in_figure(2*squeeze( convn(lffc, normalize_integral(low_spatial_bandwidth), 'valid') ), ['intermediate: low spatial bandwidth, slope ' num2str(slope)] );
  imshow_in_figure(2*squeeze( convn(lffc, normalize_integral(low_angular_bandwidth), 'valid') ), ['intermediate: low angular bandwidth, slope ' num2str(slope)] );
  imshow_in_figure(2*squeeze( convn(lffc, normalize_integral(low_spatialxangular_bandwidth), 'valid') ), ['intermediate: (low spatial bandwidth) * (low angular bandwidth), slope ' num2str(slope)] );
  imshow_in_figure(2*squeeze( convn(lffc, normalize_integral(ears), 'valid') ), ['intermediate: ears, slope ' num2str(slope)] );
  
  
  imshow_in_figure(2*squeeze( convn(lffc, normalize_integral(final), 'valid') ), ['final for slope ' num2str(slope)] );
