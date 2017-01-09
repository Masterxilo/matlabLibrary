g = gaussian4d(repmat(7, 1, 4), eye(4)/2) % this corresponds to a standard deviation of sqrt(2)

%% 2d slice
imshow_in_figure(rescale01(g(:,:,3,3)), '2d slice')

%% 3d
g1=g(:,:,:,1);
assert(minX(g1) >= 0);

show_isosurfaces(g1);