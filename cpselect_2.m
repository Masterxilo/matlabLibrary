function [points1, points2] = cpselect_2(image1, image2)
  % second variant of a tool that allows interactive selection
  % of corresponding points in image1 and image2
  %
  % points* are n x 2 of the same size with the same order
  % such that corresponding points are on the same row
  
  uiwait_msgbox('Select corresponding points in the two images: Select any amount in the first image ');
  
  
  fig = figure('Name', 'Select characteristic points in image1');
  imshow(image1);
  title('Select characteristic points in image1');
  
  points1 = getpts2(fig); % maybe use ginput?
  
  numPoints = size(points1,1);
    
  close(fig);
  
  % show result for reference
  rfig = figure();
  hold on;
  imshow(image1);
  scatter2(points1','x');
  text(points1(:,1),points1(:,2),num2str((1:numPoints)'));
  
    
  fig = figure('Name', 'Select same amount of corresponding points in image2 in same order');
  imshow(image2);
  title('Select same amount of corresponding points in image2 in same order');
  
  points2 = getpts2(fig);
  
  close(fig);
  close(rfig);
  
  if size(points2, 1) ~= numPoints
      error('Wrong amount of points!\n');
      return;
  end
  