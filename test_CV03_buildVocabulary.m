% prototypes CV03_buildVocabulary

% 1. build 'image iterator' returning an image or [] for a small test
% dataset (two images)
image1 = CV03_dataAintNobody_frame(5);
image2 = CV03_dataAintNobody_frame(6);
images = {image1, image2, []}
images_f = @(i) cell2mat(images(i))

%%
sifts = CV03_runSiftOnImages(images_f)

%%
k_vocabularySize = 100;

%%
vocabularyDescriptors = CV03_buildVocabularyCenters(sifts,k_vocabularySize);

%%
[wordids, inverseIndex] = CV03_buildVisualWordInverseIndex(sifts, vocabularyDescriptors)

%%
bowHistograms = CV03_buildBagOfWordHistograms(wordids,k_vocabularySize);

%%
o = struct();
o.wordids = wordids;
o.bowHistograms = bowHistograms;
o.vocabularyDescriptors = vocabularyDescriptors;
o.inverseIndex = inverseIndex;


o