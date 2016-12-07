% reproduces P8051 ca. slide 63

hw = [480 640];
hw2 = [floor(480*4/3) floor(640*3/2)];

a = single_color_rgb_image(hw, [1 0 0]);
b = single_color_rgb_image(hw, [0 1 0]);

mask = boundary_distance_mask_manhattan(hw); % boundary_distance_mask_manhattan(2)

a = padarray(a, hw2-hw, 'post');
b = padarray(b, hw2-hw, 'pre');

maska = padarray(mask, hw2-hw, 'post');
maskb = padarray(mask, hw2-hw, 'pre');

assert_same_size12(maska, a);

close all
imshow_in_figure(a,'a');
imshow_in_figure(rescale1(maska),'maska');
imshow_in_figure(b,'b');
imshow_in_figure(rescale1(maskb),'maskb');

o = imblend(a, maska, b, maskb);
imshow_in_figure(o,'blend result');
