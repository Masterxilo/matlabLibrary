close all
figure('Name', 'y axis')
line_implicit_dot_homogeneous(100,100,[1 0 0]) % the y axis: [1 0 0] * [x y 1] == 0

figure('Name', 'x axis')
line_implicit_dot_homogeneous(100,100,[0 1 0]) % the x axis: [0 1 0] * [x y 1] == 0

figure('Name', 'x = y')
line_implicit_dot_homogeneous(100,100,[-1 1 0]) % the x = y line: [-1 1 0] * [x y 1] == 0

figure('Name', 'y = x + 1')
line_implicit_dot_homogeneous(3,3,[-1 1 -1]) % the y = 1 + x line: [-1 1 -1] * [x y 1] == 0
axis([0 3 0 3])