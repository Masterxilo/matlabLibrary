% lightfield demo
x = load('IMG_0099__Decoded.LFToolbox.mat');
lf = x.LF;

close all

% Extract only inner 7x7 colors for confident
% parts of the image, c.f. test_LF.m
lffc = uint16toUnorm(lf(8-3:8+3,8-3:8+3,3:end-2,3:end-2,1:3));  % ca. 1.5 GB/4

%% Subsampling spatially for speedup
lffc = lffc(:,:,1:2:end,1:2:end, :);

%% Inner subimage
lffc = lffc(:,:,200-80:200+80,300-100:300+200, :);


%% Subsampling color for speedup
lffc = lffc(:,:,1:2:end,1:2:end, 1);

%% Inner image
imshow_in_figure(2*squeeze(lffc(7,7,:,:,:)), 'Inner Image');

%% Start playing around with 4d gaussian
std = [2,2,2,2]; sz = [7 7 8 8]; % only spatial size may vary. Should theoretically be infinite, anything smaller is an optimization
std = [2,2,1.5,1.5]; sz = [7 7 5 5];
gauss = gaussian4d(sz,covariance_matrix4(std));

conved = convn(lffc, gauss, 'valid'); 
imshow_in_figure(squeeze(conved)*2, ['4d gaussian']);
imshow_in_figure(rescale01(squeeze(gauss(3,:,1,:))), 'gaussian mask');

%% Start playing around with 4d gaussian with slope
% Observations:
% * the larger the spatial blur, the less prominent
% the effect of different slopes
% * the angular blur should not be too small
% otherwise the effect cannot be noticed (but it cannot be bigger than what
% a 7x7 gaussian kernel meaningfully supports)

spat = 0.3;
std = [1,1, spat,spat]; sz = [7 7 5 5]; 
slope = -0.4; % +-0.8 % -0.4 % 0.6

% more playing
spat = 1;
ang = 5;
std = [ang,ang, spat,spat]; sz = ceil([7 7 spat*3 spat*3]); 
slope = -0.8; % +-0.8 % -0.4 % 0.6

% more playing
spat = 1.5;
ang = 2;
std = [ang,ang, spat,spat]; sz = ceil([7 7 spat*3 spat*3]); 
slope = -0.8; % +-0.8 % -0.4 % 0.6


% more playing
spat = 0.5;
ang = 7;
std = [ang,ang, spat,spat]; sz = ceil([7 7 spat*3 spat*3]); 
slope = -0.8; % +-0.8 % -0.4 % 0.6

%for slope=-0.9:0.1:0.9
gauss = gaussian4d(sz,covariance_matrix_shear4(std, slope));

%imshow_in_figure(rescale01(squeeze(gauss(3,:,1,:))), ['gaussian mask with slope ' num2str(slope)]);

conved = convn(lffc, gauss, 'valid'); 

imshow(2*squeeze(conved))
title(['4d gaussian with slope ' num2str(slope)]);
% _in_figure

pause(0.001)
%end


%% Combining low spatial and low angular bandwidth
slope = 0.4;
slope = -0.4; % +-0.8 % -0.4 % 0.6


spatsz = 8;

spat = 0.5; ang = 7;

std = [ang,ang, spat,spat]; sz = ceil([7 7 spatsz spatsz]); 
low_angular_bandwidth = gaussian4d(sz,covariance_matrix_shear4(std, slope));


spat = 2.5; ang = 2; 

std = [ang,ang, spat,spat]; sz = ceil([7 7 spatsz spatsz]); 
low_spatial_bandwidth = gaussian4d(sz,covariance_matrix_shear4(std, slope));

% Convolve to obtain ears
low_spatialxangular_bandwidth = convn(low_angular_bandwidth, low_spatial_bandwidth,'same'); % normalize this or not?

% add ears to body
final = low_spatial_bandwidth + (low_angular_bandwidth - low_spatialxangular_bandwidth);

%imshow_in_figure(rescale01(squeeze(final(3,:,1,:))), ['gaussian mask with
%slope ' num2str(slope)]); % show filter

imshow_in_figure(2*squeeze( convn(lffc, normalize_integral(final), 'valid') ));
title(['final, slope ' num2str(slope)] );
% _in_figure

%%
imshow_in_figure(2*squeeze( convn(lffc, normalize_integral(low_angular_bandwidth), 'valid') ), 'low_angular_bandwidth' );
imshow_in_figure(2*squeeze( convn(lffc, normalize_integral(low_spatial_bandwidth), 'valid') ), 'low_spatial_bandwidth' );
imshow_in_figure(2*squeeze( convn(lffc, normalize_integral(low_spatialxangular_bandwidth), 'valid') ), 'low_spatialxangular_bandwidth' );

%%
imshow_in_figure(2*squeeze( convn(lffc, normalize_integral(low_angular_bandwidth - low_spatialxangular_bandwidth), 'valid') ), 'low_angular_bandwidth - low_spatialxangular_bandwidth' );

%%
slope = -0.4;
spatsz = 8;
final = CP06_make_final_filter( 7, 0.5, 2, 2.5, spatsz, slope); % filter 
imshow_in_figure(2*squeeze( convn(lffc, normalize_integral(final), 'valid') ), ['final, slope ' num2str(slope)] );
