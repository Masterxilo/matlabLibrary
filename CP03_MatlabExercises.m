% Matlab Exercises for Computational Photography Project 03
% c.f. P8041
% This document can be published. Most exercises should be run in order.

%% 1. (a)
%
close all
N = 16;

figure('Name', 'sampling cosines')
for k=1:N
    wo = 2 * pi * k / N;
    f = @(x) cos(wo * x);
    fn = arrayfun(f, 0:N);

    subplot(4,4,k);
    hold on
    fplot(f, [0 N]);
    stem(0:N, fn);
    title(['k = ' num2str(k)]);
end

%% 1. (b)
% The Nyquist frequency is reached at k = 8.
%
% In the above graphs, note that all sampling patterns beyond k = 8
% already occurred before! There is no way these can be distinguished.
%
% The nyquist sampling theorem can also be understood very easily in the
% fourier domain.

%% 2. (a)
M = 7;
DFTM = dftMatrix(M)

%% 2. (b)
U = DFTM/sqrt(M);
U * conj(U)

%% 2. (c)
% real part of (the first few) DFT matrix rows == cosines
%
% It's obvious from the construction of the matrix and euler's theorem
% why this is the case.
%
% It's easier to observe when M is big.

M = 64;
DFTM = dftMatrix(M);

close all

for k=1:5
    subplot(5,1,k);
    plot(1:M, real(DFTM(k,:)));
    title(['row ' num2str(k)]);
end

%% 2. (d)
% There is only one frequency present, thus only two coefficients
% of the fourier series are nonzero, and they are exactly at mirrored
% positions around the middle coefficient a_0 after fftshift (if M is odd).
%
% This can be explained with the translation of the complex fourier series
% coefficients to the sin-cos series coefficients.
%
% See also slide 47.

M = 15;
k = 2;
f = @(x) cos(k * x);
fn = arrayfun(f, 2 * pi * (0:(M-1)) / M);
slowdft(fn)
r = fft(fn)'

% They are basically the same (this is almost 0)
max(abs(slowdft(fn) - fft(fn)'))

% centered
fftshift(r)

%% 2. (e)
% The naive DFT has O(n^2) but FFT has O(n log(n)).
%

% Speedup is enormous:
n=10^6
n^2/(n*log(n))

%% 3. (a)

close all
gimage = imread8toDoubleGrayscale('imageBlend2.jpg'); % anything

imshow_in_figure(gimage, 'The image we will be taking the fft of')
ft = fft2(gimage);

%% 3. (b)
% Basically 0
sum(sum(gimage)) - ft(1,1)

%% 3. (c)
% TODO This is wrong...
%F = ft(:);
%i = gimage(:);
%sum(i.*i) - sum(F .* conj(F))

%% 3. (d)
ftc = fftshift(ft);

%% 3. (e)
close all
imshow_in_figure(rescale01(log(1 + ftc .* conj(ftc))), 'logarithm of the powerspectrum of the centered fft of the above image')
% called showfftLogPowerSpectrum from now on

%% 3. (f)
% Use hue/angular colors, which makes sense for the phase angle

close all
t = 'Phase angle of the fft';
figure('Name', t)
imshow(angle(ftc),[])
title(t)

colormap('hsv')
c = colorbar;
c.Label.String = 'Phase angle (in radians)';
caxis([-pi pi])

%% 4. (a)

close all
gimage = grayscale(imread8toDouble('tablecloth960.png')); % another image just for kicks

imshow_in_figure(gimage, 'the image')

mn = 2*size(gimage);
m = mn(1);
n = mn(2);
ft = fft2(gimage,m,n);

figure('Name', 'FFT power spectrum of the image')
showfftLogPowerSpectrum(ft)


%% 4. (b)
% TODO what is n?
%n = 1;

%[x,y] = meshgrid(-k:k);
%D = sqrt(x.^2+y.^2);

%bwHighpass = 1 / (1 + (D / D0)^(2*n));
%bwBandpass = 1 / (1 + (W * D / (D .* D - D0^2))^(2*n));
% TODO visualize

%% 4. (c)
% TODO 

%% 4. (d)
% TODO 

%% 5. (a)
close all
gimage = grayscale(imread8toDouble('imageBlend2.jpg'));

imshow_in_figure(gimage, 'original image')

blurKernel = fspecial('gaussian', 22, 3);
%blurKernel = ifft2(fft2(blurKernel, matrixHeight(gimage), matrixWidth(gimage)));
%blurKernel = blurKernel + 0.0001; % make blur kernel nonzero everywhere
%blurKernel = blurKernel / total(blurKernel);

imshow_in_figure(rescale01(blurKernel), 'blur kernel')

blurredGimage = imfilter(gimage,blurKernel,'circular');%imgaussfilt(gimage, 3);

imshow_in_figure(blurredGimage,'blurred image. Note the circular boundary conditions')

%% 5. (b)
close all

blurredNoisedGimage = imnoise(blurredGimage, 'gaussian', 0, 0.05);
imshow_in_figure(blurredNoisedGimage, 'blurred + noised image')

%% 5. (c)
% TODO this does not work quite right

close all

blurKernelfft = fft2(blurKernel, matrixHeight(gimage), matrixWidth(gimage));
blurredNoisedGimagefft = fft2(blurredNoisedGimage);
blurredGimagefft = fft2(blurredGimage);

figure()
showfftLogPowerSpectrum(blurKernelfft)
title('blur kernel fft')

figure()
showfftLogPowerSpectrum(blurredNoisedGimagefft)
title('blurredNoisedGimagefft')

figure()
showfftLogPowerSpectrum(blurredGimagefft)
title('blurredGimagefft: note that high frequencies where eliminated. Note that this is blur kernel fft .* fft')

figure()
showfftLogPowerSpectrum(fft2(gimage))
title('gimagefft')

imshow_in_figure(ifft2(blurredNoisedGimagefft ./ blurKernelfft), 'inverse filtered blurred + noised image')

figure()
blurKernelfftInverse = blurKernelfft .* (blurKernelfft ~= 0) + 1*(blurKernelfft == 0); % set inverse to 1 where kernel is 0
showfftLogPowerSpectrum(blurredGimagefft .* blurKernelfftInverse)
title('inverse filtered blurred image fft')

imshow_in_figure(ifft2(blurredGimagefft .* blurKernelfftInverse), 'inverse filtered blurred image')

%% 5. (d)
% TODO

%% 6. (a)
% We should set coefficients which have a small magnitude (norm, modulus)
% to zero, because these frequencies have low power so they don't 
% contribute much to the final image.
%
% We should -not- just cut off high frequencies (ideal low-pass filter),
% since this will just give a blurry image.
%

%% 6. (b)
close all
ratioSetToZero = 0.95; % must be between 0 and 1 % compression factor

gimage = grayscale(imread8toDouble('imageBlend2.jpg'));

imshow_in_figure(gimage, 'Image to be compressed')
save('gimage', 'gimage');

ft = fft2(gimage); % not fft(), fft2! Interestingly fft also works

figure()
showfftLogPowerSpectrum(ft)
title('Fourier spectrum of image')
save('ft', 'ft');

power = ft .* conj(ft);
orderedPower = sort(power(:));

set0Threshold = orderedPower(1 + floor((length(orderedPower)-1)*ratioSetToZero));

truncatedFt = ft .* (power > set0Threshold);

figure()
showfftLogPowerSpectrum(truncatedFt)
title([num2str(100*ratioSetToZero) '% Truncated fourier spectrum of image'])
save('truncatedFt', 'truncatedFt');

%% 6. (c)
% See above. We save gimage, ft and truncatedFt

%% 6. (d)
close all
load('truncatedFt');

restoredGimage = ifft2(truncatedFt);

imshow_in_figure(gimage, 'Original image')

imshow_in_figure(restoredGimage, [num2str(100*ratioSetToZero) '% Compressed image'])

%% 6. (e)
% The L2 norm error of the compressed image will be the same as the L2 norm
% error of the truncated fft, due to Parseval's Theorem.
%
% fft does not do normalization, so actually we have to do some
% adjustments, namely divide by sqrt(matrixHeight(gimage)).
%
% How much L2 error we introduce by setting x% of the lowest powers
% in the fft to 0 depends on the actual distribution of power.
% It certainly cannot be more than the original image's total L2 norm.

disp(['L2 norm of original image: ' num2str(norm(gimage(:)))]);
% TODO how to measure this? Does it need to be normalized or not?
disp(['"Normalized" L2 norm of fft of original image (same -> Parseval!): ' num2str(norm(ft(:) )) ] ) %/ sqrt(matrixHeight(gimage))))])

disp('---')
disp(['L2 error of compressed image: ', num2str(norm(gimage(:) - restoredGimage(:)))])
disp(['"Normalized" L2 error of truncatedFt (same -> Parseval!): ', num2str(norm(ft(:) - truncatedFt(:)) ) ])%/ sqrt(matrixHeight(gimage)))])

disp('---')
% TODO why is this not equal to the L2 norm of the uncompressed image minus
% the L2 error?
disp(['L2 norm of compressed image: ' num2str(norm(restoredGimage(:)))]);

%% 6. (f)
PercentSetTo0 = [];
FileSize = [];
L2Error = [];

wb = waitbar_start('compressing gimage to different degrees...');
for percentSetTo0=0.1:0.05:0.95
    waitbar(percentSetTo0);
    [filesize, l2error] = fftCompressGetFileSizeL2Error(gimage, percentSetTo0);
    
    PercentSetTo0 = [PercentSetTo0;percentSetTo0];
    FileSize = [FileSize;filesize];
    L2Error = [L2Error;l2error];
end
close(wb);

disp(table(PercentSetTo0,FileSize,L2Error))

%% Bonus
% jpeg compression uses the discrete cosine transform (DCT).
% They use a different color space and store more information for the 
% brightness than for the color, because human vision can distinguish
% brightness better than color.
%
% They store high frequency coefficients with less accuracy.
% They decompose the image into blocks.
