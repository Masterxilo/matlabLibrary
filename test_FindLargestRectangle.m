i = rescale01(fspecial('gaussian',100,70)) > 0.5; % make some image with non-trivial largest inscribed rectangle

close all
imshow_in_figure(i, 'image and largest rectangle inscribed');
hold on
[x,y,w,h] = FindLargestRectangle(i)
rectangle('Position', [x,y,w-1,h-1]);