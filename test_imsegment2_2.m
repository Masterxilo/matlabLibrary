% real-world data test

% dataset selection
%a = 'ForegroundBackgroundImage_Downsampled.png'; b = 'ForegroundBackgroundImageForegroundMask_Downsampled.png'; c = 'ForegroundBackgroundImageBackgroundMask_Downsampled.png';
%a = 'ForegroundBackgroundImage.png'; b = 'ForegroundBackgroundImageForegroundMask.png'; c = 'ForegroundBackgroundImageBackgroundMask.png';
%a = 'ForegroundBackgroundImage2.png'; b = 'ForegroundBackgroundImage2ForegroundMask.png'; c = 'ForegroundBackgroundImage2BackgroundMask.png';
%a = 'imsegment2_example1.jpg'; b = 'imsegment2_example1_foreground_mask.jpg'; c = 'imsegment2_example1_background_mask.jpg';
%a = 'imsegment2_example1_Downsampled.jpg'; b = 'imsegment2_example1_foreground_mask_Downsampled.jpg'; c = 'imsegment2_example1_background_mask_Downsampled.jpg';
a = 'imsegment2_example2.jpg'; b = 'imsegment2_example2_foreground_mask.jpg'; c = 'imsegment2_example2_background_mask.jpg';
%a = 'imsegment2_example2_Downsampled.jpg'; b = 'imsegment2_example2_foreground_mask_Downsampled.jpg'; c = 'imsegment2_example2_background_mask_Downsampled.jpg';

image = imread8toDouble(a); 
foreground = imread8toDoubleGrayscale(b) > 0.5;
background = imread8toDoubleGrayscale(c) > 0.5; 

close all
figure(1)
imshow(image)

figure(2)
imshow(foreground)

figure(3)
imshow(background)

figure(4)
labels = imsegment2(image, foreground, background, 3);
figure(1)
imshow(immask(image, labels))

figure(2)
imshow(immask(image, 1-labels))