%% Computer Vision 2015 Assignment 1
% P8128.pdf
% This code was originally called solntemplate.m.
% I have removed the directory handling (the data iss assumed to be on the
% path somewhere, e.g. in the testing Fixtures folder).

% Publish this document to see the results.

% L must be computed, after that the datasets can be run in any order

% Datasets are labeled (prefixed) with ps.

%% Spatial coordinates:
% We'll assume a right handed coordinate frame with
% X to the right, Y down, Z in the direction we are looking.
% We assume orthographic imaging, with the camera coords 
% aligned with world coordinates.
close all
L = CV01_EstimateLightDirections()

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loop over the test image sets to be used

%%
close all
CV01_runOnDataset(L, 'ps.gray');

%%
close all
CV01_runOnDataset(L, 'ps.buddha');

%%
close all
CV01_runOnDataset(L, 'ps.cat');

%%
close all
CV01_runOnDataset(L, 'ps.owl');

%%
close all
CV01_runOnDataset(L, 'ps.horse');

%%
close all
CV01_runOnDataset(L, 'ps.rock');