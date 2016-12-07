% Image morphing via delauny triangulation
% for Computational Photography hs2016, Project 05 (P8050).
%
% Look at test_immorph_delauny_out*.avi for some ready made movies 
% of the kind that can be produced with this tool.

userSelectedPoints = false; % set this to true to specify the corresponding points by hand rather than using some pre-made ones

%% Selection
close all
image1 = face1_1000();
image2 = face2_1000();

if userSelectedPoints
  [points1, points2] = cpselect_1(image1, image2);
else
  o = cpstruct_72_face_1_2_1000();
  points1 = o.inputPoints;
  points2 = o.basePoints;
  points1 = points1-rand(size(points1));
  points2 = points2-rand(size(points2));
  points1 = max(points1, ones(size(points1)));
  points2 = max(points2, ones(size(points2)));
end

assert_same_size(points1, points2);
disp('points ok');

%% Show points
close all
imshow_in_figure(image1, 'image1');
hold on
scatter2(points1');

imshow_in_figure(image2, 'image2');
hold on
scatter2(points2');

%% Calculate the delaunay triangulation 
% this will be repeated in immorph_delaunay, we just visualize it here
close all
imshow_in_figure(image1, 'image1 delaunay triangulation');
tri = delaunay(points1);
hold on
triplot2(tri, points1);


%% Compute the interpolating movie
% and save it to morphToolOutput.avi
delta = 0.25; % in (0,1) controls by how much time each frame of the movie advances
movieFPS = 3; % frames per second of the final movie

f = @(alpha) im2frame(clamp01(...
  immorph_delaunay(image1, points1, image2, points2, alpha) ...
  ));

F = arrayfun_struct(f, 0:delta:1);

figure()
movie(F) % does not display very nicely: does not scale, cannot be looped etc.
title('movie')
movie_to_avi(F, 'morphToolOutput.avi', movieFPS) % look at this file
