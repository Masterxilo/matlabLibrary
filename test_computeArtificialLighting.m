load('ps.owl.mask.mat', 'mask')
load('ps.owl.normals.mat', 'normals')
load('ps.owl.colorAlbedo.mat', 'colorAlbedo')

close all

i = computeArtificialLighting(colorAlbedo, normals, mask, normalize_array([-1;-1;-1]));
imshow_in_figure(i,'Synthetically Shaded Image [-1;-1;-1]');

i = computeArtificialLighting(colorAlbedo, normals, mask, normalize_array([1;1;-1]));
imshow_in_figure(i,'Synthetically Shaded Image [1;1;-1]');