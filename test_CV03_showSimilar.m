% Display images most similar to some random image.

%% dataset - could use any set of images with computed vocabulary
v = CV03_dataAintNobody_vocabulary();
n = CV03_dataAintNobody_framecount();
images_f = @CV03_dataAintNobody_frame;


%%
bowHistograms = v.bowHistograms;
imId = randi(n);

% Compute distance to all other images by bow histogram dot product.
imHis = bowHistograms(imId,:);
[ids, rating] = CV03_findClosestHistogram(imHis, bowHistograms);

% top should be the image itself
assert(ids(1) == imId);

%% === Visualize ===
close all
imshow_in_figure( images_f(imId), ['image' num2str(imId) ' score ' num2str(rating(imId))]); 

%%
CV03_showSimilar(ids, rating, images_f)
