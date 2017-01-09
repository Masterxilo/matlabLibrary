% compute just one frame with timing

image1 = face1_1000();
image2 = face2_1000();

o = cpstruct_72_face_1_2_1000(); %   cpstruct_10_face_1_2_1000 cpstruct_72_face_1_2_1000

% avoid out-of-range points
points1 = o.inputPoints; % + 2 to compensate out-of range points 
points2 = o.basePoints;

% add some perturbations to avoid pixel-perfect positions which
% can cause missing pixels after rasterization
points1 = points1-rand(size(points1));
points2 = points2-rand(size(points2));

% avoid out-of-range points
% TODO avoid too big points
points1 = max(points1, ones(size(points1))); % + 2 to compensate out-of range points 
points2 = max(points2, ones(size(points2)));

assert_same_size(points1, points2);

tic
out = immorph_delaunay(image1, points1, image2, points2, 0.5);
toc

close all 
imshow_in_figure(out, 'immorph');