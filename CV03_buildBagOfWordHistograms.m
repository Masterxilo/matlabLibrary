function bowHistograms = CV03_buildBagOfWordHistograms(wordids, k_vocabularySize)
  % given the word of each descriptor, build the histogram, i.e.
  % count how many words of each type are present
  %
  % wordids is a cell array
  % bowHistograms is n x k_vocabularySize
  
  n = length(wordids);
  
  assert(n >= 2 && k_vocabularySize > 2); % sanity check
  
  bowHistograms = zeros(n, k_vocabularySize);
  hw = waitbar_start('building b.o.w. histograms');

  for i=1:n
      waitbar(i/n, hw);
      
      assert(isrow(cell2mat(wordids(i))));
      
      bowHistograms(i, :) = histc(cell2mat(wordids(i)), 1:k_vocabularySize);
  end

  close(hw);