% For Computational Photography, Project 06, P8146
% Task 1
%

% Make sure Images and Cameras (with proper white images/calibration) are in the current folder before running
% this.
%
% Generates files of the format *__Decoded.mat and *__Decoded_Thumb.png
% in the same folder as the lytro .lfp/.lfr files under Images.
%
% Important Note: I have *not* included the Cameras folder or the processed lightfield .mat file
% in my hand-in (because they are huge). Therefore you HAVE TO add the Cameras folder from PROJECT06 on the Lytro's SD card
% to this folder and you HAVE TO run this before any of the other exercises. Thank you!

%% Decoding images
close all 
% Make sure there are images in Images\Illum

%LFUtilDecodeLytroFolder([], [], struct('OptionalTasks', 'ColourCorrect')) % I don't like their color-correction (too much saturation), so I don't use it
LFUtilDecodeLytroFolder

% That's it.