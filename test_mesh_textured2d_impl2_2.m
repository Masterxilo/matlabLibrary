% test with larger texture and output and more triangles (optimizations pay
% off more for more triangles)

close all

texture = lena();

texture_vertices = [ 
    1 1
    300 20
    10 500
    500 500
    512 256
    ];

output_size = [1000 1000];

vertices = 9*[ 
    30 80
    10  20
    100 50
    100 10
    50 1];

triangles = [1 2 3;3 2 4;4 2 5];

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