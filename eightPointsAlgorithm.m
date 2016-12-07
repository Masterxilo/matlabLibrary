function [F] = eightPointsAlgorithm(x1,x2, normalized)
% Calculates the Fundamental matrix (computer vision)
% between two views from the 
%   normalized eight-point algorithm
%
% Inputs: 
% x1      3xN     normalized* homogeneous coordinates of matched points in view 1
% x2      3xN     normalized* homogeneous coordinates of matched points in view 2
% *  (3rd component is always 1)
% Outputs:
%               F       3x3     Fundamental matrix
% Such that for each x2 * F * x1 ~ 0


% 'Equivalent' call of internal OpenCV function:
% - Why do the epipolar lines exactly intersect in one point with this?


% c.f. P8132, Questions 1.3 and 2.1

if nargin < 3
    normalized = true;
end
[F] = eightPointsAlgorithmImpl1(x1,x2, normalized)

