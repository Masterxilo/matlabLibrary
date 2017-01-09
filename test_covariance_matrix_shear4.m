close all

% different sigmas to test (change the order to select one)
s = [2 2 2 2];
s = repmat(sqrt(2), 1, 4);
s = [1 2 2 2]; % more flat in x direction
s = [2 1 2 2]; % more flat in y direction
s = [2 2 1 2]; % more flat in z direction

slope = 1; % this will shear x as z increases and y as w increases (displayed via multiple 3d slices below)

% make sure this is big enough to showcase what we want to see
out_size = repmat(9, 1, 4);

g = gaussian4d(out_size, covariance_matrix_shear4(s, slope));

%% 2d slice
imshow_in_figure(rescale01(g(:,:,3,3)), '2d slice');
test_covariance_matrix_shear4_2
%% 3d
for i=1:2:9
g1=g(:,:,:,i);
assert(minX(g1) >= 0);
show_isosurfaces(g1,num2str(i))
end
