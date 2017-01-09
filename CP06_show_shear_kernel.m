function CP06_show_shear_kernel( s, out_size,slope)
  % for cp06_3
  
  assert(all(2*s < out_size)); % sanity: output size should be large enough for at least one standard deviation in both dirs
  
  % this will shear x as z increases and y as w increases (displayed via multiple 3d slices below)
  g = gaussian4d(out_size, covariance_matrix_shear4(s, slope));

  %% 2d slices
  imshow_in_figure(rescale01(squeeze(g(:,1,:,1))), 'x - z slice'); % 
  imshow_in_figure(rescale01(squeeze(g(1,:,1,:))), 'y - w slice'); % 
  %imshow_in_figure(rescale01(squeeze(g(:,:,1,1))), 'xy slice (no shear)'); % 
  %imshow_in_figure(rescale01(squeeze(g(1,1,:,:))), 'zw slice (no shear)'); % 
  %imshow_in_figure(rescale01(squeeze(g(:,1,1,:))), 'x w slice'); % 
  %imshow_in_figure(rescale01(squeeze(g(1,:,:,1))), 'y z slice'); % 
  
  %% 3d slice
  i = floor(out_size(1)/2);
  g1=g(:,:,:,i);
  assert(minX(g1) >= 0);
  show_isosurfaces(g1,num2str(i));