close all
r = imreaddouble('rectification1_rect.png');
imshow_in_figure(r, 'source image');

hi = [0.1E1,(-0.113332E0),0.802392E2;0.E-307,0.993099E0,0.488559E1; ...
  0.E-307,(-0.248567E-3),0.117599E1] % found with rectification.nb in Mathematica, now implemented in homography2d()

o = imtransform_bilinear_full_homography(r, hi);
imshow_in_figure(o, 'result');
