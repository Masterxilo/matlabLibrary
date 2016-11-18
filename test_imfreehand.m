image = imread8toDouble('imsegment2_example1.jpg');

uiwait(msgbox('Draw the foreground mask'));
foreground = imfreehand_mask_image(image);