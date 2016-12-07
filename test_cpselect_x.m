%% tool 1
close all
[points1, points2] = cpselect_1(imreaddouble('bs.left.cp.jpg'), imreaddouble('bs.right.cp.jpg'))

%% tool 2, more crude
close all
[points1, points2] = cpselect_2(imreaddouble('bs.left.cp.jpg'), imreaddouble('bs.right.cp.jpg'))