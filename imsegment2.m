function label_image = imsegment2(image, regionAhint, regionBhint, color_gmm_gaussian_components_count) 
  % segment a color image into two regions by using GraphCut
  % on a color-model, see gmmcolormodel
  %
  % color_gmm_gaussian_components_count: 1 to 3 should be enough
  %
  % This is similar in spirit (but not implementation I think) to
  % Mathematica's GrowCutComponents and some example data can be found there.
  %
  % Out implementation uses GraphCut from addpath('GCMex')
  % 
  % image color image
  % regionAhint binary mask of the same size as the image
  % regionBhint binary mask of the same size as the image
  % 
  % The masks (hints) should cover (be 1 at) as many pixels as possible of regionA
  % or regionB which must be disjoint.
  % Returns the region assignments, that is, the segmentation,
  % i.e. for each pixel a number 0 (A) or 1 (B) depending on which region it was
  % estimated to belong to.
  
  assert(isreal(image));
  assert(islogical(regionAhint));
  assert(islogical(regionBhint));
  assert_same_size12(image, regionAhint);
  assert_same_size12(image, regionBhint);
 
  
  A_dist = gmmcolormodel_for_immaskcolors(image, regionAhint, color_gmm_gaussian_components_count);
  B_dist = gmmcolormodel_for_immaskcolors(image, regionBhint, color_gmm_gaussian_components_count);
  
  % debug color model
  %figure(2)
  %show_colors(A_dist.mu')
  %figure(3)
  %show_colors(B_dist.mu')
  
  A_pdf = @(x) pdf(A_dist, x(:)');
  B_pdf = @(x) pdf(B_dist, x(:)');
  
  assert(A_pdf([1 1 1]) >= 0 && B_pdf([0 0 0]) >= 0); % sanity
  
  % (( visualize color models
show_colors(A_dist.mu', 'Region A Gmm colormodel means');
imshow_in_figure(rescale01(map_each_pixel(A_pdf, image)), 'Region A probability at each pixel');

show_colors(B_dist.mu', 'Region B Gmm colormodel means');
imshow_in_figure(rescale01(map_each_pixel(B_pdf, image)), 'Region B probability at each pixel');
  %))
  label_image = imsegment2_pdf(image, regionAhint, regionBhint, A_pdf, B_pdf);
  
  
  
  