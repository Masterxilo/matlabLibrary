vl_setup2()

close all

i1 = (imread('panorama1_left.jpg')); % 'panorama1_left.jpg'
i2 = (imread('panorama1_right.jpg')); % 'panorama1_left.jpg'

[f1, d1] = vl_sift(single(grayscale(i1)));%, 'PeakThresh', 2); % feature threshold % default values work ok
[f2, d2] = vl_sift(single(grayscale(i2)));%, 'PeakThresh', 2);

imshow_in_figure(i1, 'features in i1');
vl_plotframe_yk( f1 );

imshow_in_figure(i2, 'features in i2');
vl_plotframe_yk( f2 );


[m, s] = vl_ubcmatch(d1, d2);%, 2); % pass d*, not f*! % threshold 2

imshow_in_figure(i1, 'matches in i1');
vl_plotframe_yk( f1(:,m(1,:)) );

imshow_in_figure(i2, 'matches in i2');
vl_plotframe_yk( f2(:,m(2,:)) );

figure()
size(i1)
size(i2)
vl_ubcmatch_show_vert(i1, f1, i2, f2, m)
title('corresponding matches')