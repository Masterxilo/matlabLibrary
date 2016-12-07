% we know that these points have this relationship

cow = read_wobj('cow.obj');
o = load('cow_stereo_points.mat');
p = o.allX; % 3 x m
q = cow.vertices'; % 3 x n

a = points_radius(p)
b = points_radius(q)

assert(0 < a);

assert(a < b);