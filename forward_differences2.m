function [vdiff, hdiff] = forward_differences2(A)
    % Computes the gradient's x and y component by forward differencing.
    % Returns all horizontal and vertical differences, i.e. matrices of
    % sizes
    %
    % vdiff: (m-1) x n
    % hdiff: m x (n-1)
    % 
    % A: m x n
    
    vdiff = A(2:end,:)-A(1:end-1,:);
    hdiff = A(:,2:end)-A(:,1:end-1);