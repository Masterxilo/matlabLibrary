% same as test_mesh_textured2d_2 but specifically changed for testing mesh_textured2d_impl2

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

triangles = [1 2 3;3 2 4];

tic
pixels1 = mesh_textured_2d_impl1(vertices, texture_vertices, triangles, texture, output_size);
toc
tic
pixels2 = mesh_textured_2d_impl2(vertices, texture_vertices, triangles, texture, output_size);
toc

assert_equal(size12(pixels1), output_size)
assert_equal(size12(pixels2), output_size)
assert_equal(pixels1, pixels2)
%assert_equal(size(pixels,3), size(texture,3))% same channels

imshow_in_figure(pixels2, 'pixels, target triangles via triplot')
hold on
triplot(triangles, vertices(:,1), vertices(:,2));