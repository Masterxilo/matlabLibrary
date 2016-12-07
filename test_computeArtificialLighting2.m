load('ps.owl.mask.mat', 'mask')
load('ps.owl.normals.mat', 'normals')
load('ps.owl.colorAlbedo.mat', 'colorAlbedo')

close all

figure()
for L=CV01_SyntheticLightDirections()
  i = computeArtificialLighting(colorAlbedo, normals, mask, L);
  imshow(i);
  title('Synthetically Shaded Image');
  pause(0.1)
end