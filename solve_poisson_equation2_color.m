function output_color_image = solve_poisson_equation2_color(color_target_image, desired_forward_difference_gradient_fields, binary_mask)
    % desired_forward_difference_gradient_fields is (h-1) x (w-1) x 2 x 3
    % same as solve_poisson_equation_color but solves the system directly, using solve_poisson_equation2 for each component
    
    output_color_image = solve_poisson_equationX_color(color_target_image, desired_forward_difference_gradient_fields, binary_mask, @solve_poisson_equation2);
   