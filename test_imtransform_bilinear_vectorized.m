close all
source_image = imreaddouble('monalisa.jpg');%imdownsample(imreaddouble('monalisa.jpg'));
imshow_in_figure(source_image, 'source image');

range = [0 1 0 1];
f = @(p2n) sqrt(p2n);
target_image = imtransform_bilinear(source_image, range, range, size12(source_image), f, 0, 1); % c.f. Mathematica ImageTransformation example
imshow_in_figure(target_image, 'target image');