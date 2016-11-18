function output_list = solve_poisson_equation_1d(target_list, desired_forward_derivative_field, binary_mask, gauss_seidel_iteration_count)
    % compute a list that matches target_list exactly at all
	% pixels where binary_mask is 0 (false), and which has gradients which match 
    % desired_forward_derivative_field as closely as possible where binary_mask is 1.
    %
    % The derivatives are given as forward-differences,
    % they must be defined at all points with binary_mask == 1 
    % (*) and at points immediately to the left of such points.
    %
    % This implementation cannot solve for border-pixels, pixels with
    % binary_mask == 1 must have at least distance 2 from the image
    % borders.
    %
    % target_list is of length n
    % desired_forward_derivative_field is of length (n-1)
    % binary_mask is of length n & logical
    % gauss_seidel_iteration_count is >= 1 (rounded down)
    
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
    
    % Gauss seidel iteration
    % Boils down to looping over unknown points and computing the average
    % of the values enforced by the immediate neighbor's values and the 
    % gradients from here to there.
    
    for gauss_seidel_iteration=1:gauss_seidel_iteration_count
       for i=1:n
          if binary_mask(i) == 0
              continue
          end
          assert(i ~= n && i ~= 1); % cannot compute both gradients for points on the boundary
          
          neighbor_values = output_list([i-1 i+1]);
          neighbor_gradients = desired_forward_derivative_field([i-1 i]); % c.f. (*)
          neighbor_gradients = neighbor_gradients .* [1 -1]';
          
          output_list(i) = mean(neighbor_values + neighbor_gradients);
       end
    end
    
    
