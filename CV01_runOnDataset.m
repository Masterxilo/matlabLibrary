function [mask, colorImages, normals, albedo, colorAlbedo, depth] = CV01_runOnDataset(L, name)
  % All computations
  [mask, colorImages] = CV01_readMaskAndColorImages(name);
  
  [normals, albedo] = CV01_estimateNormalsAndAlbedo(L, colorImages, mask);
  colorAlbedo = CV01_estimateColorAlbedo(L, colorImages, normals, mask);
  
  % Visualizations of computed results
  imshow_in_figure(normals2rgb(normals), 'Normals R=X,G=-Y,B=-Z, normalized. Negative z points to camera');
  imshow_in_figure(albedo, 'BW Albedo');
  imshow_in_figure(colorAlbedo,'Color Albedo');
  
  depth = depthFromNormals(normals,mask);
  imshow_in_figure(rescale01(depth), 'Depth Map, darker means closer');
  
  % Depth as mesh
  figure();
  meshz(depth);
  colormap(jet(256));
  title('Estimated Depth as Mesh');
  xlabel('x');
  ylabel('y');
  zlabel('z');
  axis equal;
  
  % Animation with new shading
  figure();
  ax = axes();
  for L=CV01_SyntheticLightDirections()
    i = computeArtificialLighting(colorAlbedo, normals, mask, L);
    imshow(i, 'Parent', ax);
    title(ax, 'Synthetically Shaded Image');
    pause(0.1)
  end