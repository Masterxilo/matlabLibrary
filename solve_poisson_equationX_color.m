function output_color_image = solve_poisson_equationX_color(color_target_image, desired_forward_difference_gradient_fields, binary_mask, solve_poisson_equationX)
    % desired_forward_difference_gradient_fields is (h-1) x (w-1) x 2 x 3
    % same as solve_poisson_equation_color but solves the system directly, using solve_poisson_equation2 for each component
    output_color_image = [];

    % ((
    hf = figure('Name', 'Poisson reconstruction in progress...');
    figure_reset(hf);
    ha = axes();
    imshow(rescale01(desired_forward_difference_gradient_fields(:,:,1,1)), 'Parent', ha); % just show something
    % ))
    
    for i=1:3
      %((  
      disp(['color channel ' num2str(i)]);
        %))
        output_color_image(:,:,i) = solve_poisson_equationX(color_target_image(:,:,i), desired_forward_difference_gradient_fields(:,:,:,i), binary_mask);
        
      %((  
        imshow(output_color_image(:,:,i), 'Parent', ha);
        title(ha, ['Poisson reconstruction in progress: Channel ' num2str(i) ' done:']);
        %))
    end
      %((  
    close(hf);
        %))