vl_setup2()

i = imread('panorama1_left.jpg');
[f,d] = vl_sift(single(rgb2gray(i)));

imshow(i)
vl_plotframe_yk(f)