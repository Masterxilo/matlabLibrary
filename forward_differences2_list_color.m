function r = forward_differences2_list_color(image)
    % returns gradient array as expected by solve_poisson_equation
    %
    % r: (height-1) x (width-1) x 2 x 3
    %
    % A: height x width x 3
    %
    
    r = []; % zeros(size(A,1)-1, size(A,2)-1, 2, 3); % [];
    
    for i=1:3
      r(:,:,:,i) = forward_differences2_list(image(:,:,i));
    end
    