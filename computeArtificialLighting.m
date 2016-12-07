function im = computeArtificialLighting(colorAlbedo, normals, mask, lightDirection)
  % simple n . L artificial lighting 
  % on all pixels where mask is true
  assert(iscolumn(lightDirection));
  assert(length(lightDirection) == 3);
  
  imsize = size(mask);
  im = reshape(colorAlbedo(:),imsize(1)*imsize(2),3) .* repmat(reshape(normals(:),imsize(1)*imsize(2),3) * lightDirection, 1,3);
  im = clamp01(im);
  im = reshape(im, [imsize, 3]);
  