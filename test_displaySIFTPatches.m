%%
n = 10;
sifts = CV03_dataAintNobody_sifts();
sift = sifts(n)
image = CV03_dataAintNobody_frame(n);

%%
close all
imshow_in_figure(image, 'image');
displaySIFTPatches(sift.positions, sift.scales, sift.orients)