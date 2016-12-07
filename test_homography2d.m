p = run_ans('rectification1_rect_matlab.m');
pt = run_ans('rectification1_rect_target_matlab.m');

h = homography2d(p, pt)

assert_approximately_equal(h, [
    1.0000    0.0969  -68.6342
    0.0000    1.0059   -4.1790
    0.0000    0.0002    0.8495
    ]);

hi = inv(h)

hi_expected = [0.1E1,(-0.113332E0),0.802392E2;0.E-307,0.993099E0,0.488559E1; ...
  0.E-307,(-0.248567E-3),0.117599E1] % found with rectification.nb in Mathematica, now implemented in homography2d()

assert(approximately_equal_up_to_scale(hi, hi_expected))

hi2 = homography2d(pt, p) % another way to get the inverse homography

assert(approximately_equal_up_to_scale(hi, hi2))