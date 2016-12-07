close all
r = imreaddouble('rectification1_rect.png');
imshow_in_figure(r, 'source image');

f = @(x,y) [x;y]/2 + [1/2;1/2];

o = imtransform_bilinear_full(r, f);
imshow_in_figure(o, 'result');
