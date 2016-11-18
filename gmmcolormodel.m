function gmdistribution_obj = gmmcolormodel(colors, gaussian_components_count)
  % given a 3 x n array of RGB colors, builds
  % a gmdistribution object with gaussian_components_count many gaussians
  % to represent the approximate distribution of the given color samples.
  %
  %
  % Used in GraphCut image segmentation.
  %
  % returns a gmdistribution_OBJ which can be accessed using pdf()
  % - gmdistribution_obj.mu will be a k x 3 matrix containing the estimated
  %   average colors, use show_color...
  % - @(x) pdf(dist, x) is a function returning a value between 0 and 1 for
  % every [0,1]^3 rgb color.
  
  assert(size(colors,1) == 3);
  assert(gaussian_components_count > 0);
   
  %colors' % must have more rows than columns. Must have enough variations
  %(add some rand() if not...) to really distinguish
  %gaussian_components_count many sub-distributions -- otherwise
  %ill-conditioned variance matrices arise and the fitting method does not converge
  %
  % c.f. test_imsegment2
  gmdistribution_obj = gmdistribution.fit(colors', ceil(gaussian_components_count));
  