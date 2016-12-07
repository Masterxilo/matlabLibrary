% more triangles

close all
texture = [];
texture(:,:,1) = [1 0;0 0];
texture(:,:,2) = [0 0;1 1];
texture(:,:,3) = [0 1;0 0];

texture_vertices = [ 
    1 1
    2 1
    1 2
    2 2];

output_size = [81 100];

vertices = [ 
    30 80
    10  20
    100 50
    100 10];

triangles = [1 2 3;3 2 4]; % 3 2 4 because we need clockwise (...) ordering for rasterize! (assertion error will be thrown if not)

imshow_in_figure(texture, 'texture triangles via triplot');
hold on;
triplot(triangles, texture_vertices(:,1), texture_vertices(:,2));

imshow_in_figure(zeros(output_size), 'target triangles via triplot');
hold on;
triplot(triangles, vertices(:,1), vertices(:,2));


pixels = mesh_textured2d(vertices, texture_vertices, triangles, texture, output_size);

assert_equal(size12(pixels), output_size);

imshow_in_figure(pixels, 'pixels, target triangles via triplot');
hold on;
triplot(triangles, vertices(:,1), vertices(:,2));