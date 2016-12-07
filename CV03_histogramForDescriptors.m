function h = CV03_histogramForDescriptors(descriptors, vocabularyDescriptors) 
    k_vocabularySize = size(vocabularyDescriptors, 1);  % not descriptors 
    assert(k_vocabularySize > 2);
    
    wordids = CV03_computeVisualWordsForDescriptors(descriptors, vocabularyDescriptors);
    h = histc(wordids, 1:k_vocabularySize);
    
    assert(length(h) == k_vocabularySize);