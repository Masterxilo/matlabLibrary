function n = normals2rgb(normals)
  % takes a m x n x 3 array of per-pixel normalized normals and remaps them 
  % to the [0,1] range by centering around 0.5
  n = normals .* repmat(reshape([1 -1 -1],1,1,3),[size(normals,1) size(normals,2)]);
  n = n * 0.5 + 0.5;