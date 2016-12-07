% Illustrates descriptor matching with either the provided 'twoFrameData'
% or with some prepared dataset.
%
% This gives two fixed frames, rather than finding the frame with the most
% matching descriptors.
%
% TODO this should only select sift patches mostly within the selected
% region, not just with their center in there.

%% Load two frames
a = 2;
b = 3;

sifts = CV03_dataAintNobody_sifts();
sift1 = sifts(a); sift2 = sifts(b);
im1 = CV03_dataAintNobody_frame(a); positions1 = sift1.positions; scales1 = sift1.scales; orients1 = sift1.orients; descriptors1 = sift1.descriptors;
im2 = CV03_dataAintNobody_frame(b); positions2 = sift2.positions; scales2 = sift2.scales; orients2 = sift2.orients; descriptors2 = sift2.descriptors;

%% or:
%load('twoFrameData.mat')

%%
% Show frame 1
close all
imshow_in_figure(im1, 'im1')

% Let the user select a region of it
onids = selectRegionPoints(im1, positions1);

% show all sift patches within that region
displaySIFTPatches(positions1(onids, :), scales1(onids, :), orients1(onids, :))

%% Find descriptors most closely matching any of those in frame 2
%[matches, scores] = vl_ubcmatch(', descriptors2')
minid = dist2nearest(descriptors1(onids,:), descriptors2);

% Display matching
imshow_in_figure(im2, 'im2')
displaySIFTPatches(positions2(minid, :), scales2(minid, :), orients2(minid, :))