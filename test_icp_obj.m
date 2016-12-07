% Align cow_stereo_points.mat to cow.obj using icp
% result kinda ok

%%

cow = read_wobj('cow.obj');

%% Prepare data for icp
o = load('cow_stereo_points.mat');
p = o.allX; % 3 x m

q = cow.vertices'; % 3 x n
q_normals = cow.vertices_normal'; % 3 x n

%% Visualize base data
close all
figure()
hold on
scatter3_3n(p, 'r','.')
scatter3_3n(q, 'b','.')
axis equal;

%% First get the scaling of p 'right' (icp does not do that)

% radius approach does not work
%a = points_radius(p);
%b = points_radius(q);
%ps = p .* (b / a);

a = max(bounding_box_sizes_dn(p));
b = max(bounding_box_sizes_dn(q));
ps = p .* (b / a);

%% Visualize again
close all
figure()
hold on
scatter3_3n(ps, 'r','.')
scatter3_3n(q, 'b','.')
axis equal;

%% rotate around z by 180 to help icp
% better initial guess
psr = [-1 0 0;0 -1 0;0 0 1] * ps;

close all
figure()
hold on
scatter3_3n(psr, 'r','.')
scatter3_3n(q, 'b','.')
axis equal;

%% Align to center of bbox for better initial guess
psrm = points_dn_add(psr, -bounding_box_center_dn(psr) + bounding_box_center_dn(q));

close all
figure()
hold on
scatter3_3n(psrm, 'r','.')
scatter3_3n(q, 'b','.')
axis equal;


%% run icp, takes a bit of time, no progress report
[TR, TT, ER, t] = icp(q, psrm, 'Minimize', 'plane', 'Normals', q_normals);

%% apply transform
% (TR * p + TT)
n = size(p,2);
pt = points_dn_add(TR * psrm, TT);% (TR * psrm + repmat(TT, 1, n));
assert_same_size(pt, p);

% visualize result
close all
figure();
hold on
scatter3_3n(q, 'b','.');
scatter3_3n(pt, 'r','.');
axis equal;