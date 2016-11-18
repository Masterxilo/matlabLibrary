% See html/ for published version of this
% We use more color components for the gmms for better results

addpath('Implementation')
addpath('Implementation/GCMex')

%% Example 1
imsegment2_demo('imsegment2_example1.jpg','imsegment2_example1_foreground_mask.jpg','imsegment2_example1_background_mask.jpg',4);

%% Example 2
% this has lots of colors
imsegment2_demo('imsegment2_example2.jpg','imsegment2_example2_foreground_mask.jpg','imsegment2_example2_background_mask.jpg',6);