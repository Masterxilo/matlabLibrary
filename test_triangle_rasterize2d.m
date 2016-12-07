close all
texture = lena();
texture_vertices = [ 
    1 1
    300 20
    10 500];

imshow_in_figure(texture, 'texture')
triangle_labeled(texture_vertices);


output_size = [81 100];
vertices = [ 
    10  20
    100 50
    30 80];

imshow_in_figure(zeros(output_size), 'target')
triangle_labeled(vertices);


[pixels, mask, points_in_triangle] = triangle_rasterize2d(vertices, texture_vertices, texture, output_size);

assert_equal(size(mask), output_size)
assert_equal(size12(pixels), output_size)

imshow_in_figure(mask, 'mask & points_in_triangle')
scatter2(points_in_triangle);
triangle_labeled(vertices);

imshow_in_figure(pixels, 'pixels')
triangle_labeled(vertices);