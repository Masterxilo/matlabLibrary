function [new_best_h, best_m] = homography2d_ransac2(p1, p2, k, dist_threshold)
  % same as homography2d_ransac, but computes the best homography again from all the inliers
  
  if nargin < 3
    k = 1000;
  end
  
  if nargin < 4
    dist_threshold = 10; % assuming pixels, this seems a reasonable default
  end
  
  [best_h, best_m] = homography2d_ransac(p1, p2, k, dist_threshold)
  
  % find all inliers again (TODO this is already computed in homography2d_ransac and repeated redundantly here)
  p1t = homography_transform(best_h, p1);
  inliers = find(mask_inliers_2d(p1t, p2, dist_threshold));
  
  assert(length(inliers) == best_m); % check that we did indeed come up with the same
  
  % Re-Compute homography from these pairs
  assert(length(inliers) >= 4);
  assert(isvector(inliers));
  
  new_best_h = homography2d(p1(:,inliers), p2(:,inliers));
  
  % verify that we did come up with something else when we should
  if length(inliers) > 4
    assert(anyX(best_h ~= new_best_h));
  end