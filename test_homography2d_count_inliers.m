p = run_ans('rectification1_rect_matlab.m');
pt = run_ans('rectification1_rect_target_matlab.m');

% for exactly 4 points, all of them are inliers
assert(homography2d_count_inliers(p,pt,1:4,0.0001) == 4);