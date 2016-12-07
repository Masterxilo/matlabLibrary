% test images 
hw = [480 640];
hw2 = [floor(480*4/3) floor(640*3/2)];
a = single_color_rgb_image(hw, [1 0 0]);
b = single_color_rgb_image(hw, [0 1 0]);
a = padarray(a, hw2-hw, 'post');
b = padarray(b, hw2-hw, 'pre');

close all
imshow_in_figure(a,'image');
imshow_in_figure(b,'filler');
imshow_in_figure(imfillholes(a,b),'imfillholes(a,b)');
