function imsegment2_demo(filename_image, filename_foreground, filename_background, gmm_components)
% example datasets:
%a = 'ForegroundBackgroundImage_Downsampled.png'; b = 'ForegroundBackgroundImageForegroundMask_Downsampled.png'; c = 'ForegroundBackgroundImageBackgroundMask_Downsampled.png';
%a = 'ForegroundBackgroundImage.png'; b = 'ForegroundBackgroundImageForegroundMask.png'; c = 'ForegroundBackgroundImageBackgroundMask.png';
%a = 'ForegroundBackgroundImage2.png'; b = 'ForegroundBackgroundImage2ForegroundMask.png'; c = 'ForegroundBackgroundImage2BackgroundMask.png';
%a = 'imsegment2_example1.jpg'; b = 'imsegment2_example1_foreground_mask.jpg'; c = 'imsegment2_example1_background_mask.jpg';
%a = 'imsegment2_example1_Downsampled.jpg'; b = 'imsegment2_example1_foreground_mask_Downsampled.jpg'; c = 'imsegment2_example1_background_mask_Downsampled.jpg';
%a = 'imsegment2_example2.jpg'; b = 'imsegment2_example2_foreground_mask.jpg'; c = 'imsegment2_example2_background_mask.jpg';
%a = 'imsegment2_example2_Downsampled.jpg'; b = 'imsegment2_example2_foreground_mask_Downsampled.jpg'; c = 'imsegment2_example2_background_mask_Downsampled.jpg';

    image = imread8toDouble(filename_image); 
    foreground = imread8toDoubleGrayscale(filename_foreground) > 0.5;
    background = imread8toDoubleGrayscale(filename_background) > 0.5; 
    
    imsegment2_demo_sub(image, foreground, background);
