close all
figure()
[points1, points2] = CV02_bscp_points();
match_show_vert(imreaddouble('bs.left.cp.jpg'), points1', imreaddouble('bs.right.cp.jpg'), points2')

figure()
[points1, points2] = CV02_bscp_points2();
match_show_vert(imreaddouble('bs.left.cp.jpg'), points1', imreaddouble('bs.right.cp.jpg'), points2')