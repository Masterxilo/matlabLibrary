function [points1, points2] = CV02_bscp_points3()
  % for CV02_bscp_images3
  % n x 2
  o = load('CV02_bscp_points3.mat');
  points1 = o.leftPoints([1 2],:)';
  points2 = o.rightPoints([1 2],:)';