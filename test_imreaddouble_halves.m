imshow_in_figure('Apollo_stereo.jpg','Apollo_stereo.jpg');
[i1, i2]  = imreaddouble_halves('Apollo_stereo.jpg');
imshow_in_figure(i1, 'l');
imshow_in_figure(i2, 'r');