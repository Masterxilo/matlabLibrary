close all
texture = lena();
vertices = [ 
    10  20
    100 50
    30 80];
vertices2 = 4*vertices;
triangles = [1 2 3];

pixels = mesh_lerp_textured2d(vertices, texture, vertices2, texture, triangles, 0);
imshow_in_figure(pixels, '0');
pixels = mesh_lerp_textured2d(vertices, texture, vertices2, texture, triangles, 0.5);
imshow_in_figure(pixels, '0.5');
pixels = mesh_lerp_textured2d(vertices, texture, vertices2, texture, triangles, 1);
imshow_in_figure(pixels, '1');