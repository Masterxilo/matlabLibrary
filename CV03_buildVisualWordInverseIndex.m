function [wordids, inverseIndex] = CV03_buildVisualWordInverseIndex(sifts, vocabularyDescriptors)
% Build inverse index (for each visual word, find the images that contain
% it)
% -> for each of n images, mark the visual words it contains
% wordids: Caching descriptor-word associations for build bag of word histograms
% later. wordids is a cell array, because every frame can have a different
% amount of descriptors computed for it.
%
% inverse index is logical k_vocabularySize x n, 1 at (i,j) iff word i
% occurs in image j.

k_vocabularySize = size(vocabularyDescriptors, 1);
assert(size(vocabularyDescriptors, 2) == 128);

n = length(sifts);
inverseIndex = zeros(k_vocabularySize,n);

wordids = {};

hw = waitbar_start('buildVisualWordInverseIndex');
for i=1:n
    waitbar(i/n,hw);
    
    descriptors = sifts(i);
    descriptors = descriptors.descriptors;
    
    current_wordids = CV03_computeVisualWordsForDescriptors(descriptors, vocabularyDescriptors);
    assert(isrow(current_wordids));
    wordids(i) = { current_wordids };
    
    for k=[current_wordids] % for k in wordids
        inverseIndex(k,i) = 1; 
    end
end
close(hw);