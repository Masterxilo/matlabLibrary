close all
source_image = imreaddouble('monalisa.jpg');%imdownsample(imreaddouble('monalisa.jpg'));
imshow_in_figure(source_image, 'source image');

range = [0 1 0 1];
f = @(x,y) sqrt([x;1-y]) .* [1;-1] + [0;1];
target_image = imtransform_bilinear(source_image, range, range, size12(source_image), f); % c.f. Mathematica ImageTransformation example
imshow_in_figure(target_image, 'target image');