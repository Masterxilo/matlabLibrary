close all

% different sigmas to test (change the order to select one)
s = [2 2 2 2];
s = repmat(sqrt(2), 1, 4);
s = [1 2 2 2]; % more flat in x direction
s = [2 1 2 2]; % more flat in y direction
s = [2 2 1 2]; % more flat in z direction

% make sure this is big enough to showcase what we want to see
out_size = repmat(9, 1, 4)

g = gaussian4d(out_size, covariance_matrix4(s))

%% 2d slice
imshow_in_figure(rescale01(g(:,:,3,3)), '2d slice')

%% 3d
g1=g(:,:,:,1);
assert(minX(g1) >= 0);

show_isosurfaces(g1)
