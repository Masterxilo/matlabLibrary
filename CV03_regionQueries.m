% Select image region, find all images most closely matching the histogram
% *computed only from this region*.
% Other than this, fullFrameQueries is quite similar (it just defines the
% whole image as the region).

%% dataset - could use any set of images with computed vocabulary
v = CV03_dataAintNobody_vocabulary();
n = CV03_dataAintNobody_framecount();
images_f = @CV03_dataAintNobody_frame;
sifts = CV03_dataAintNobody_sifts();


%%
bowHistograms = v.bowHistograms;

imId = randi(n);

%% Show selected image
close all
imshow_in_figure( images_f(imId), ['image' num2str(imId) ' & region']); 

%% Let the user select a region of it
positions = sifts(imId).positions;
onids = selectRegionPoints(images_f(imId), positions);
assert(isvector(onids));
assert(length(onids) > 0);

%% Compute distance to all other images by bow histogram dot product.
imHis = CV03_histogramForDescriptors(sifts(imId).descriptors(onids,:), v.vocabularyDescriptors);

%%
[ids, rating] = CV03_findClosestHistogram(imHis, bowHistograms);
title(['image' num2str(imId) ' & region, rating' num2str(rating(imId))]);

%% display the patches under the selection
displaySIFTPatches(sifts(imId).positions(onids, :), sifts(imId).scales(onids, :), sifts(imId).orients(onids, :))

%%
CV03_showSimilar(ids, rating, images_f)
