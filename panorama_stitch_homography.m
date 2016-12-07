function best_h = panorama_stitch_homography(i1, i2, homography_estimator)
  % find homography that best transforms feature points in i1 to
  % corresponding points in i2
  %
  % see test_homography2d_ransac for development of this
  if nargin < 3
    homography_estimator = @homography2d_ransac;
  end
  
  vl_setup2();

  [f1, d1] = vl_sift(single(grayscale(i1)));%, 'PeakThresh', 2); % feature threshold % default values work ok
  [f2, d2] = vl_sift(single(grayscale(i2)));%, 'PeakThresh', 2);

  [m, s] = vl_ubcmatch(d1, d2);%, 2); % pass d*, not f*! % threshold 2

  % 
  [p1, p2] = correspondence_reorder(f1(1:2,:), f2(1:2,:), m);

  % apply homography2d_ransac
  [best_h, ~] = homography_estimator(p1, p2);

