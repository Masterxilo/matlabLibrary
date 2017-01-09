x = load('IMG_0099__Decoded.LFToolbox.mat');
lf = x.LF;

close all

%%
slope = -0.4;
r = LFFiltShiftSum(lf, slope);
imshow_in_figure(2*r(:,:,1:3), [num2str(slope) ' slope']);

%%
slope = 0.4;
r = LFFiltShiftSum(lf, slope);
imshow_in_figure(2*r(:,:,1:3), [num2str(slope) ' slope']);