%%
vl_setup2();
image = lena();
f = vl_sift(rgb2gray(single(image)), 'PeakThresh', 0.05);

close all
imshow_in_figure(image, 'image');
displaySIFTPatches2(f)

%% compare with
imshow_in_figure(image, 'image');
vl_plotframe_yk(f)

