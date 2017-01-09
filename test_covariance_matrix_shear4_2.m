close all

% different sigmas to test (change the order to select one)

s = repmat(sqrt(2), 1, 4);
s = [1 2 2 2]; % more flat in x direction
s = [2 1 2 2]; % more flat in y direction
s = [2 2 1 2]; % more flat in z direction
s = [2 2 2 2]*2;

slope = 3; % this will shear x as z increases and y as w increases (displayed via multiple 3d slices below)

% make sure this is big enough to showcase what we want to see
out_size = repmat(35, 1, 4);

g = gaussian4d(out_size, covariance_matrix_shear4(s, slope));

%% 2d slices
imshow_in_figure(rescale01(squeeze(g(:,1,:,1))), 'x - z slice'); % 
imshow_in_figure(rescale01(squeeze(g(1,:,1,:))), 'y - w slice'); % 
imshow_in_figure(rescale01(squeeze(g(:,:,1,1))), 'xy slice (no shear)'); % 
imshow_in_figure(rescale01(squeeze(g(1,1,:,:))), 'zw slice (no shear)'); % 
imshow_in_figure(rescale01(squeeze(g(:,1,1,:))), 'x w slice'); % 
imshow_in_figure(rescale01(squeeze(g(1,:,:,1))), 'y z slice'); % 
