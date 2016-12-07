i = panorama_stitch_example_mask();

close all

imshow_in_figure(double(i), 'i');
hold on
[x, y, w, h] = FindLargestRectangle(i);

rectangle('Position', [x,y,w-1,h-1]);