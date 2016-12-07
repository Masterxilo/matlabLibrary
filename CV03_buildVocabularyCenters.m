function vocabularyDescriptors = CV03_buildVocabularyCenters(sifts, k_vocabularySize)
  % sifts is ruSift result on all images
  % output is k_vocabularySize x 128 cluster centers
  
  sampledDescriptors = CV03_sampleDescriptors(sifts);
  
  % Build visual vocabulary from sampled descriptors
  disp('waiting for k-means');
  % [
  %[~,vocabularyDescriptors] = kmeans(sampledDescriptors, k_vocabularySize);
  % Alternatively [
  [~,vocabularyDescriptors] = kmeansML(k_vocabularySize, double(sampledDescriptors'));
  vocabularyDescriptors = vocabularyDescriptors';
  % ]
  disp('k-means finished');

  assert(size(vocabularyDescriptors, 1) == k_vocabularySize);
  assert(size(vocabularyDescriptors, 2) == 128);