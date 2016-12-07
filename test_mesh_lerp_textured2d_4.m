% morphing test
% note that the cpstruct_10_face_1_2_1000 triangulation is very coarse,
% thus many important features such as the eyes are not properly aligned
%
% prepares for immorph_delaunay

close all 
texture = face1_1000();
texture2 = face2_1000();

o = cpstruct_10_face_1_2_1000();
vertices = o.inputPoints; 
vertices2 = o.basePoints;

triangles = delaunay(vertices);

imshow_in_figure(texture, 'texture, face1, inputPoints');
hold on;
triplot(triangles, vertices(:,1), vertices(:,2));

imshow_in_figure(texture2, 'texture, face2, basePoints');
hold on;
triplot(triangles, vertices2(:,1), vertices2(:,2));

pixels = mesh_lerp_textured2d(vertices, texture, vertices2, texture2, triangles, 0);
imshow_in_figure(pixels, '0');
pixels = mesh_lerp_textured2d(vertices, texture, vertices2, texture2, triangles, 0.5);
imshow_in_figure(pixels, '0.5');
pixels = mesh_lerp_textured2d(vertices, texture, vertices2, texture2, triangles, 1);
imshow_in_figure(pixels, '1');