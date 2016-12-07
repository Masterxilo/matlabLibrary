% simpler test, showcasing bilinear interpolation
% same as test_triangle_rasterize2d_2

close all
texture = [];
texture(:,:,1) = [1 0;0 0];
texture(:,:,2) = [0 0;1 1];
texture(:,:,3) = [0 1;0 0];

texture_vertices = [ 
    1 1
    2 1
    1 2];

output_size = [81 100];

vertices = [ 
    10  20
    100 50
    30 80];

triangles = [1 2 3];

imshow_in_figure(texture, 'texture')
triangle_labeled(texture_vertices);

imshow_in_figure(texture, 'texture triangles via triplot')
hold on
triplot(triangles, texture_vertices(:,1), texture_vertices(:,2));

imshow_in_figure(zeros(output_size), 'target')
triangle_labeled(vertices);

imshow_in_figure(zeros(output_size), 'target triangles via triplot')
hold on
triplot(triangles, vertices(:,1), vertices(:,2));


pixels = mesh_textured2d(vertices, texture_vertices, triangles, texture, output_size);

assert_equal(size12(pixels), output_size)

imshow_in_figure(pixels, 'pixels')
triangle_labeled(vertices);

imshow_in_figure(pixels, 'pixels, target triangles via triplot')
hold on
triplot(triangles, vertices(:,1), vertices(:,2));