function output_grayscale_image = solve_poisson_equation(grayscale_target_image, desired_forward_difference_gradient_field, binary_mask, gauss_seidel_iteration_count)
	% compute an image that matches grayscale_target_image exactly at all
	% pixels where binary_mask is 0, and which has gradients which match 
    % desired_gradient_field as closely as possible where binary_mask is 1.
    %
    % The gradients are given as forward-differences, all differences
    % surrounding unknown (mask == 1) pixels must be valid.
    %
    % Cannot solve for boundary pixels (special cases not implemented).
    %
    %
    % grayscale_target_image is height x width. Used as initial guess.
    %
    % desired_forward_difference_gradient_field is (height-1) x (width-1) x
    % 2 and laid out as returned by forward_differences2_list: 
    %   - desired_forward_difference_gradient_field(:,:,1) contains the vertical differences, 
    %   - desired_forward_difference_gradient_field(:,:,2) contains the horizonal differences, 
    %
    % binary_mask is height x width, logical
    %
    % gauss_seidel_iteration_count is >= 1 (rounded down)
    %
    
    assert(isrealnumber(gauss_seidel_iteration_count));
    gauss_seidel_iteration_count = floor(gauss_seidel_iteration_count);
    assert(gauss_seidel_iteration_count >= 1);
    
    
    % assert(assert_same_size(grayscale_target_image, binary_mask)); %
    % binary_mask is one bigger
    [height width] = size(grayscale_target_image);
    [gheight gwidth two] = size(desired_forward_difference_gradient_field);
    assert(gheight+1 == height);
    assert(gwidth+1 == width);
    assert(2 == two);
    assert(islogical(binary_mask));
    assert(isreal(grayscale_target_image));
    assert(isreal(desired_forward_difference_gradient_field));
    
    % Use the same naming as in the slides:
    % out === output_grayscale_image
    out = grayscale_target_image; % initialize unknown portion with target image
    % guidance field:
    vy = desired_forward_difference_gradient_field(:,:,1);
    vx = desired_forward_difference_gradient_field(:,:,2);
    
    % TODO use find() to speed up looping only over the pixels not masked
    % out
    % TODO consider sorting pixels from outside to inside to speed up
    % information propagation speed (distance transform...)
    % TODO how much faster can we do this if we build the sparse matrix and
    % solve the system?
    
    % ((
    hf = figure('Name', 'solve poisson equation Gauss-Seidel iteration progress');
    figure_reset(hf);
    ha = axes();
    imshow(out, 'Parent', ha);
    title(ha, ['solve poisson equation Gauss-Seidel iteration ' num2str(0)]);
    h = waitbar_start('solve poisson equation Gauss-Seidel iterations...');
    % ))
    
    for gauss_seidel_iteration=1:gauss_seidel_iteration_count
        waitbar(gauss_seidel_iteration/gauss_seidel_iteration_count)
        for y=1:height
            for x=1:width
                
                if ~binary_mask(y,x) 
                    % this is a 'boundary' pixel, left untouched
                    continue
                end
                % yes, this is an unknown pixel that should be solved for
                assert(x ~= 1 && y ~= 1 && x ~= width && y ~= height); % cannot handle image boundary pixels

                % update pixel (y,x)
                % by solving the local leastsquares problem
                
                % formula from the slides... how?
                %out(y,x) = + ...
                 % (vy(y-1,x)-vy(y,x)+vx(y,x-1)-vx(y,x)) % sum_{q in Neighbors} v_{pq}
                
                % intuition: do the same as in the 1-d case: compute the
                % average of the value we should have according to
                % neighbors and gradients
                vxm = out(y, x-1) + vx(y, x-1);
                vxp = out(y, x+1) - vx(y, x);
                vym = out(y-1, x) + vy(y-1, x);
                vyp = out(y+1, x) - vy(y, x);
                 
                out(y,x) = mean([vxm vxp vym vyp]);
            end
        end
        
        % ((
        imshow(out, 'Parent', ha);
        title(ha, ['solve poisson equation Gauss-Seidel iteration ' num2str(gauss_seidel_iteration)]);
        % ))
        
    end
    
    % ((
    close(h);
    close(hf);
    %))
    
    % output_grayscale_image
    output_grayscale_image = out;