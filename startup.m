% this file runs when matlab starts
% http://blogs.mathworks.com/pick/2005/11/15/default-docked-figures/

%% Free Figures
%-- use this for publishing
set(0,'DefaultFigureWindowStyle','normal') % quickly clutters the desktop

%% Docked Figures
set(0,'DefaultFigureWindowStyle','docked') % docked figures do not react to set(gcf(), 'Position', get(0,'defaultfigureposition'))?!

%with windows

%matlabpool % to enable parfor

% start in this directory (for matlab frontend...)
if string_equal(computer_name(), 'paulyoga2pro')
  cd 'E:\Dropbox\Paul\matlabLibrary'
else
  cd 'C:\Users\Paul\Dropbox\Paul\matlabLibrary'
end

%% Libraries

LFMatlabPathSetup
vl_setup2