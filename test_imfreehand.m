% Demonstrates drawing a binary mask interactively in matlab.

image = imreaddouble('imsegment2_example1.jpg');
uiwait(msgbox('Draw a mask'));
mask = imfreehand_mask_image(image);

imshow_in_figure(mask, 'final mask');