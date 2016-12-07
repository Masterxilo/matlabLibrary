% Example for the "Rasterize" function.
% preparation for triangle_rasterize2d_mask

% Assume we have the trianlge
output_size = [100 100];
vertices = [ 
    10  20
    100 50
    30 80];

aabbi = bounding_box_int_overestimate(vertices);
xywh = bounding_box_to_rectangle(aabbi)
    
    
% Now, let's ask our "rasterize function" which pixels are in the
% triangles, which are outside.
out = rasterize(vertices', coordinates_list_2n([aabbi(1,1) aabbi(2,1)],[aabbi(1,2) aabbi(2,2)]));

% reshape output, such that we get back our image
size(out)

out = reshape(out, xywh(4), xywh(3));

imshow_in_figure(out, 'out')


output = zeros(output_size);
output(aabbi(1,2):aabbi(2,2), aabbi(1,1):aabbi(2,1)) = out;

imshow_in_figure(output, 'output')
hold on;
triangle(vertices);