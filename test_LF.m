% lightfield demo
x = load('IMG_0099__Decoded.LFToolbox.mat');
lf = x.LF;

close all


%% There are 15 x 15 virtual cameras


%% (A) one image, angularly parametrized (looking out from one camera location)
fimage = squeeze(lf(7,7,:,:,1:3));
fimage = uint16toUnorm(fimage);
imshow_in_figure(fimage, 'fimage');

%% one image, spatially parametrized (different virtual camera locations)
image = squeeze(lf(:,:,198,432,1:3));
image = uint16toUnorm(image);
imshow_in_figure(image);

%% (B) Extract EPI
% Move virtual camera horizontally
% stacking the corresponding lines into s

% (image size 15    15   434   626     4)
% 61 (purple stick, red/yellow petals, wooden stick)
% 219 (red vine, yellow petal)
close all
y = 61;
y = 219; 
y = 257; % text

CP06_show_horizontal_epi(lf, y)

%% Vignetting/confidence
s = squeeze(lf(:,:,198,432,4));
s = uint16toUnorm(s);
imshow_in_figure(s);

%% Confidences
confidences = uint16toUnorm(lf(:,:,:,:,4));

%% Angularly
totConf=sum(confidences, 1);
totConf=sum(totConf, 2);
totConf = squeeze(totConf);
imshow_in_figure(squeeze(totConf), 'total confidences')

%% Remove those views with 0 confidence: seems to be the 2-pixel border on both sides
imshow_in_figure(totConf(:,3:end-2), 'total confidences')


%% Spatially: c.f. Vignetting/confidence

%% Spatially: Validity mask
% maybe this will be useful
% multiply all validities to find parts that are 0 somewhere 
% (pessimisitc/conservative) estimate

confidences = uint16toUnorm(lf(:,:,3:end-2,3:end-2,4)); % I noted that we should also cut away some in the y direction

pc=prod(confidences > 0.02, 3); % the 0.02 is arbitrary/experimental
pc=prod(pc, 4);
validityMask = pc;
imshow_in_figure(validityMask, 'conservative validity mask')

% This gives a bit more than a 7x7 window of data to work with! ;)

%% Extract full field in floating point
% except for the portions with 0 confidence.
lffc = uint16toUnorm(lf(:,:,3:end-2,3:end-2,1:3));  % 1.5 GB

%% Extract a single image by convolving with a filter
% that reduces the initial dimensions to 0

%% Single pixel mask
% this has the same effect as (A)
mask = zeros(15,15,1,1);
mask(7,7,1,1) = 1;

% this is pretty fast
conved = convn(lffc, mask, 'valid'); % need only the colors. 'valid' makes the image smaller, in particular, the angular dimensions fall away.
imshow_in_figure(squeeze(conved), 'conved single pixel')

%% Horizontal line mask
% What is the effect of this? Looks like slight horizontal motion blur.
% All these pixels should be valid, c.f. (B)

mask = zeros(15,15,1,1);
mask(7,:,1,1) = 1;
mask = normalize_integral(mask);

conved = convn(lffc, mask, 'valid'); 
imshow_in_figure(squeeze(conved), 'conved horizontal line')

%% Full mask
% This blurs the image a bit everywhere
conved = convn(lffc, normalize_integral(validityMask), 'valid'); 
imshow_in_figure(squeeze(conved), 'conved with validityMask')

%% Other things we could do is apply a gaussian filter 
% only spatially (blurring the whole image), 
mask = zeros(15,15,8,8); % note that we should not reduce the size of the filter: we still want to select a certain subpixel

%mask(7,7,:,:) = 1; % <- box filter.. artifacts
mask(7,7,:,:) = fspecial('gaussian', 8, 2); % <- gaussian is nicer

conved = convn(lffc, normalize_integral(mask), 'valid'); 
imshow_in_figure(squeeze(conved), 'spatial blur');

%% or only angularly
% (giving something a bit less blurry than the full mask)
%mask = zeros(15,15,1,1);
mask = fspecial('gaussian', 15, 3);

conved = convn(lffc, normalize_integral(mask), 'valid'); 
imshow_in_figure(squeeze(conved), 'angular blur');

%%
% 
% Instead of blurring the whole image, we can also blur only certain
% depths, i.e. slopes in the EPI: For this, we make the filter
% sample different camera positions in the individual subimages
% For this, we position the sampled pixels differently in the spetial
% neighborhood

% For slope in the horizontal (ignore vertical), we might do this:

slope = 4; w = 3; % should be less than 1 (?)
 % the effect is stronger the wider the kernel
 
slope = 0.5; w = 6;

assert(ceil(slope*w) < 15);
mask = zeros(15,15,1,w);
for x=1:w
  mask(7,ceil(slope*x),1,x) = 1; % nevermind centering the thing
end

imshow_in_figure(squeeze(mask(7,:,:,:)), 'slope mask');

conved = convn(lffc, normalize_integral(mask), 'valid'); 
imshow_in_figure(squeeze(conved), ['manual slope blur ' num2str(slope)]);

%% Start playing around with 4d gaussian
std = [3,3,2,2]; sz = [15 15 8 8]; % only spatial size may vary. Should theoretically be infinite, anything smaller is an optimization
std = [3,3,1.5,1.5]; sz = [15 15 5 5];
gauss = gaussian4d(sz,covariance_matrix4(std));

conved = convn(lffc, gauss, 'valid'); 
imshow_in_figure(squeeze(conved), ['4d gaussian']);
imshow_in_figure(rescale01(squeeze(gauss(7,:,1,:))), 'gaussian mask');

%% Start playing around with 4d gaussian with slope
std = [3,3,1.5,1.5]; sz = [15 15 5 5]; 
slope = 1;

for slope=0.5:0.5:1.5
  slope
gauss = gaussian4d(sz,covariance_matrix_shear4(std, slope));

imshow_in_figure(rescale01(squeeze(gauss(7,:,1,:))), ['gaussian mask with slope ' num2str(slope)]);

conved = convn(lffc, gauss, 'valid'); 
imshow_in_figure(squeeze(conved), ['4d gaussian with slope ' num2str(slope)]);

end