function [c1, c2] = correspondence_reorder(p1, p2, which)
  % given two sets of data d x n
  % and a set of indices which, 2 x k
  % extract into c1 = p1(:,which(1,:)); c2 = p2(:,which(2,:));
  %
  % apply this to reorder the descriptors of sift afte ubcmatch, for
  % example
  
  c1 = p1(:,which(1,:)); c2 = p2(:,which(2,:));
  