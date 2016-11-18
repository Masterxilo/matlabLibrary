function r = forward_differences2_list(A)
    % returns gradient array as expected by solve_poisson_equation
    %
    % r: (height-1) x (width-1) x 2
    %
    % A: height x width
    
    [m n]= size(A);
    
    [vdiff, hdiff] = forward_differences2(A);
    
    r = zeros(m-1, n-1, 2);
    r(:,:,1) = vdiff(1:m-1, 1:n-1);
    r(:,:,2) = hdiff(1:m-1, 1:n-1);