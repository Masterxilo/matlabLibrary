close all
texture = lena();

vertices = [ 
    10  20
    100 50
    30 80];

triangles = [1 2 3];

pixels = mesh_lerp_textured2d(vertices, texture, vertices, texture, triangles, 0);

assert_same_size(pixels, texture)

imshow_in_figure(pixels, 'pixels');

pixels2 = mesh_lerp_textured2d(vertices, texture, vertices, texture, triangles, 1); % should be same
assert_equal(pixels, pixels2);