function [best_h, best_m] = homography2d_ransac(p1, p2, k, dist_threshold)
  % takes two lists of the same size of possibly corresponding points,
  % tries k selections of 4 corresponding points, 
  % passes them to homography2d_count_inliers (as 'which')
  % and finally returns the homography with the most inliers
  %
  % best_m indicates how many inliers there where
  %
  % Warning: This implementation is slightly flawed because it does not 
  % recompute the homography based on the inliers.
  % Prefer homography2d_ransac2
  %
  % TODO neither implementation is deterministic/allows controlling the ransac seed
  
  if nargin < 3
    k = 1000;
  end
  
  if nargin < 4
    dist_threshold = 10; % assuming pixels, this seems a reasonable default
  end
  
  
  n = size(p1, 2);
  assert_same_size(p1, p2);
  
  best_h = eye(3);
  best_m = 0;
  
  w = waitbar_start('ransac');
  for i=1:k
    waitbar(i / k);
    
    which = randsample(n, 4)'; % TODO seed should be specified to make this deterministic! Or try all combinations (probably unfeasible)
    [m, h] = homography2d_count_inliers(p1, p2, which, dist_threshold);
    if m > best_m
      best_m = m; best_h = h;
    end
  end
  close(w);