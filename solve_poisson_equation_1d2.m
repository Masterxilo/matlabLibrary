function output_list = solve_poisson_equation_1d2(target_list, desired_forward_derivative_field, binary_mask, gauss_seidel_iteration_count)
    % same as solve_poisson_equation_1d, but constructs the sparse equation
    % system and solves that directly
    
    assert(isreal(gauss_seidel_iteration_count));
    gauss_seidel_iteration_count = floor(gauss_seidel_iteration_count);
    assert(gauss_seidel_iteration_count >= 1);
    
    target_list = target_list(:);
    binary_mask = binary_mask(:);
    desired_forward_derivative_field = desired_forward_derivative_field(:);
    
    assert_same_size(target_list, binary_mask);
    n = length(target_list);
    assert(length(desired_forward_derivative_field) == n-1);
    
    assert(islogical(binary_mask));
    assert(isreal(target_list));
    assert(isreal(desired_forward_derivative_field));
    
    % 
    output_list = target_list; % initialization
    
    % Let v be the gradient field
    v = desired_forward_derivative_field;
    
    A = sparse(1,1); b = []; m = 1; % for setting up the sparse linear equation system
    
    for i=1:n
      if binary_mask(i) == 0
          % copy input
          A(m,i) = 1; b(m) = target_list(i);
          m = m+1;
          continue
      end
      assert(i ~= n && i ~= 1); % cannot compute both gradients for points on the boundary

      % equations
      if binary_mask(i-1) == 0 % add backwards equations only once
        % (1) f(i) - f(i-1) = v(i-1)
        A(m,i) = 1;
        A(m,i-1) =-1;
        b(m) = v(i-1);
        m = m+1;
      end
      
      % (2) f(n+1) - f(n) = v(n)
      A(m,i+1) = 1;
      A(m,i) =-1;
      b(m) = v(i);
      m = m+1;
      
    end
    
    output_list = least_squares_for(A, b, target_list, binary_mask);
    
