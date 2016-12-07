close all
source_image = imreaddouble('monalisa.jpg');%imdownsample(imreaddouble('monalisa.jpg'));
imshow_in_figure(source_image, 'source image');

range = [0 1 0 1];
f = @(x,y) sqrt([x;y]);

% ,1 for zeropad, effectively padding the image with black % without
% zeropad, this fails an assertion
target_image = imtransform_bilinear(source_image, range, 2*range, size12(source_image), f, 1); % c.f. Mathematica ImageTransformation example
imshow_in_figure(target_image, 'target image');