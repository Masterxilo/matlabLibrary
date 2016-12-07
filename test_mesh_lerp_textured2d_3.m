close all
texture = lena();
texture2 = imresize(face1(), size12(texture));

m = [1 -1;1 1] / sqrt(2);
vertices = (m * ([ 
    1 1
    100 1
    1 100
    100 100] - 50)')' + 50 * sqrt(2) + 1; % just to show off that we can handle fractional coordinates

vertices2 = 2*vertices;
triangles = [1 2 3;3 2 4];

figure()
triplot(triangles, vertices(:,1), vertices(:,2))
hold on
triplot(triangles, vertices2(:,1), vertices2(:,2))


pixels = mesh_lerp_textured2d(vertices, texture, vertices2, texture2, triangles, 0);
imshow_in_figure(pixels, '0');
pixels = mesh_lerp_textured2d(vertices, texture, vertices2, texture2, triangles, 0.5);
imshow_in_figure(pixels, '0.5');
pixels = mesh_lerp_textured2d(vertices, texture, vertices2, texture2, triangles, 1);
imshow_in_figure(pixels, '1');