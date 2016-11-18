% Demonstrates naive debayering and median filtered debayering to get rid
% of some color fringing on hard edges.

img=double(imread('foliage raw.tiff')) / 4095;

imshow_in_figure(demosaicBayer(img), 'demosaicBayer(foliage raw.tiff) Note that the colors are messed up because we miss the transformation matrices');


img=double(imread('black and white raw.tif')) / 255;

imshow_in_figure(demosaicBayerMedian(img), 'demosaicBayerMedian(black and white raw.tif): note that this has no color fringing')
imshow_in_figure(demosaicBayer(img), 'demosaicBayer(black and white raw.tif): note the color fringing')
