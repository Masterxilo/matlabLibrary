function [ids, rating] = CV03_findClosestHistogram(histogram, bowHistograms)
% histogram 1xk normalized histogram of vocabulary words
% (e.g. from a full image or image region)
% ids is descending order of ratings, rating is for each image 1:n
size(histogram)
size(bowHistograms)

  assert(isrow(histogram));
  assert(ismatrix(bowHistograms));
  assert(size(bowHistograms,2) == length(histogram));
  n = size(bowHistograms, 1);

  %rating = imHis * bowHistograms'; % just dot product (assume
  %pre-normalized)

  % rating is normalized dot product
  rating = zeros(1,n);
  normHistogram = norm(histogram);
  for i = 1:n
      rating(i) = dot(histogram, bowHistograms(i,:));
      rating(i) = rating(i) / normHistogram / norm(bowHistograms(i,:));
  end    
  [~, ids] = sort(rating);
  ids = flip(ids);
end

