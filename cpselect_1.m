function [points1, points2] = cpselect_1(image1, image2)
  % first variant of a tool that allows interactive selection
  % of corresponding points in image1 and image2
  %
  % points* are n x 2 of the same size with the same order
  % such that corresponding points are on the same row
  uiwait(msgbox('Select corresponding points in the two images. Select in image1, then 2, repeat. Close the tool when done'));
  [points1, points2] = cpselect(image1, image2, 'Wait', true);