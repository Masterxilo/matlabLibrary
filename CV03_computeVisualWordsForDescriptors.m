function wordids = CV03_computeVisualWordsForDescriptors(descriptors, vocabularyDescriptors)
% Map raw SIFT descriptors to their nearest visual words
% descriptors nxd
% wordids 1xn integers from the range 1 to k (size of vocabulary) -- for
% each descriptor the closest visual word
    
    assert(size(descriptors, 2) == 128);
    assert(size(vocabularyDescriptors, 2) == 128);
    
    wordids = dist2nearest(double(descriptors), vocabularyDescriptors);
end