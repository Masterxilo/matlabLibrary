function gmdistribution_obj = gmmcolormodel_for_immaskcolors(img, mask, gaussian_components_count)
  % used for graph-cut color model
  gmdistribution_obj = gmmcolormodel(immaskcolors(img, mask), gaussian_components_count);