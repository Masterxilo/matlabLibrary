function [vocabulary, sifts] = CV03_buildVocabulary(images, k_vocabularySize)
  % sfits contains n (amount of images) results from CV03_runSift
  % vocabulary has the following members:
  % .vocabularyDescriptors
  % .inverseIndex
  % .wordids
  % .bowHistograms
  %
  % This is the format returned by
  % CV03_dataAintNobody_vocabulary(), CV03_dataAintNobody_sifts
  sifts = CV03_runSiftOnImages(images);
  assert(length(sifts) > 0);
  
  vocabulary = struct();
  
  if nargin < 2
    k_vocabularySize = 1500; % too big a vocabulary leads to overfitting, to small is not good either
  end
  
  vocabulary.vocabularyDescriptors = CV03_buildVocabularyCenters(sifts, k_vocabularySize);
  [vocabulary.wordids, vocabulary.inverseIndex] = CV03_buildVisualWordInverseIndex(sifts, vocabulary.vocabularyDescriptors);
  vocabulary.bowHistograms = CV03_buildBagOfWordHistograms(vocabulary.wordids, k_vocabularySize);
  