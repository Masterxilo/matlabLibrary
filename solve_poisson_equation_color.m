function output_color_image = solve_poisson_equation_color(color_target_image, desired_forward_difference_gradient_fields, binary_mask, gauss_seidel_iteration_count)
	% desired_forward_difference_gradient_fields is (h-1) x (w-1) x 2 x 3
  output_color_image = solve_poisson_equationX_color(color_target_image, desired_forward_difference_gradient_fields, binary_mask, @(x,y,z) solve_poisson_equation(x,y,z,gauss_seidel_iteration_count));
   
  