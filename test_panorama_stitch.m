
close all

image1 = (imreaddouble('panorama2_left.jpg')); % 'panorama(1|2)_left.jpg'
image2 = (imreaddouble('panorama2_right.jpg')); % 'panorama(1|2)_left.jpg'


imshow_in_figure(image1, 'image 1');
imshow_in_figure(image2, 'image 2');

[final_image, image_mask] = panorama_stitch(image1, image2);

imshow_in_figure(final_image, 'final image');
imshow_in_figure(image_mask, 'image mask');
