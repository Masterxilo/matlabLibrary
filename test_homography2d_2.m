p = run_ans('rectification1_rect_matlab.m');
pt = run_ans('rectification1_rect_target_matlab.m');

h2 = homography2d_impl2(p, pt)
h3 = homography2d_impl3(p, pt)

assert(approximately_equal_up_to_scale(h2, h3))