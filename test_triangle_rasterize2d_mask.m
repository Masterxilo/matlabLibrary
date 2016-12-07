output_size = [81 100];
vertices = [ 
    10  20
    100 50
    30 80];

[mask, points_in_triangle] = triangle_rasterize2d_mask(vertices, output_size);

imshow_in_figure(mask, 'output')
hold on;
triangle(vertices);
scatter2(points_in_triangle);