vl_setup2()

close all

i1 = (imreaddouble('panorama2_left.jpg')); % 'panorama(1|2)_left.jpg'
i2 = (imreaddouble('panorama2_right.jpg')); % 'panorama(1|2)_left.jpg'

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

figure('Name','corresponding matches')
size(i1)
size(i2)
vl_ubcmatch_show_vert(i1, f1, i2, f2, m)
title('corresponding matches')

% extends on the vl_ubcmatch test starting here:
[p1, p2] = correspondence_reorder(f1(1:2,:), f2(1:2,:), m);
figure('Name','corresponding matches, points only')
match_show_vert(i1, p1, i2, p2)
title('corresponding matches, points only')

%% apply homography2d_ransac2, which should give a result slightly different from homography2d_ransac

[old_best_h, old_best_m] = homography2d_ransac(p1, p2)
[best_h, best_m] = homography2d_ransac2(p1, p2)
assert(best_m == old_best_m);

% transform
imshow_in_figure(i2,'transforming p1 into p2');
hold on
scatter(p2(1,:), p2(2,:));
p1t = homography_transform(best_h, p1);
scatter(p1t(1,:), p1t(2,:), '+');

% note that images need to be 8-bits for vl_sift, but double for bilinear
% interpolation function -- nah, they can be double for sift
imshow_in_figure(imtransform_bilinear_full_homography(i1, inv(best_h), 1),'transforming i1 according to best_h');

% for further development of this, see panorama_stitch_homography, panorama_stitch