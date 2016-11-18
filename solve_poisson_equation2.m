function output_grayscale_image = solve_poisson_equation2(grayscale_target_image, desired_forward_difference_gradient_field, binary_mask)
  % like solve_poisson_equation, but constructs the sparse equation system
  % and solves that directly
  % 
  % c.f. solve_poisson_equation_1d2
    
  % assert(assert_same_size(grayscale_target_image, binary_mask)); %
  % binary_mask is one bigger
  assert(dimension(grayscale_target_image) == 2);
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
  
  %A = sparse(1,1); b = []; m = 1; % for setting up the sparse linear equation system As = b
  % [[
  %A = sparse(4 * height * width, height * width);
  A_i = zeros(4 * height * width,1);
  A_j = zeros(height * width,1);
  A_v = zeros(4 * height * width,1);
  k = 1;
  
  b = zeros(4 * height * width,1); m = 1; % optimization: initialize to estimate of final size
  % ]]
  
  Ai = @(y,x) sub2ind([height width], y, x); % index linearization (natural)
  
  flat_binary_mask = binary_mask(:);
  flat_grayscale_target_image = grayscale_target_image(:);
        
  
  h = waitbar_start('solve poisson equation2: building equation system...');
  
  for y=1:height
      waitbar(y / height);
    
      for x=1:width
        
          if ~binary_mask(y,x) 
              % this is a 'boundary' pixel, it is left untouched

              % s(y,x) == out(y,x)
              A_i(k) = m; A_j(k) = Ai(y,x); A_v(k) = 1; k = k + 1;%A(m, Ai(y,x)) = 1;
              b(m) = grayscale_target_image(y,x);
              m = m+1;

              continue
          end
          
          % yes, this is an unknown pixel that should be solved for
          %%assert(x ~= 1 && y ~= 1 && x ~= width && y ~= height); % cannot handle image boundary pixels

          Ai_y_x = Ai(y,x);
          
          
          % constraints for pixel (y,x)
          % backwards gradients only at the boundaries
          
          % backwards x
          % s(y,x) - s(y,x-1) == vx(y,x-1)
          if binary_mask(y,x-1) == 0
            A_i(k) = m; A_j(k) = Ai_y_x; A_v(k) = 1; k = k + 1;%A(m,Ai(y,x))   = 1;
            A_i(k) = m; A_j(k) = Ai(y,x-1); A_v(k) = -1; k = k + 1;%A(m,Ai(y,x-1)) = -1;
            b(m) = vx(y,x-1);
            m = m+1;
          end
          
          % backwards y
          % s(y,x) - s(y-1,x) == vy(y-1,x)
          if binary_mask(y-1,x) == 0
            A_i(k) = m; A_j(k) = Ai_y_x; A_v(k) = 1; k = k + 1;%A(m,Ai(y,x))   = 1;
            A_i(k) = m; A_j(k) = Ai(y-1,x); A_v(k) = -1; k = k + 1;%A(m,Ai(y-1,x)) = -1;
            b(m) = vy(y-1,x);
            m = m+1;
          end
          
          % forwards x
          % s(y,x+1) - s(y,x) == vx(y,x)
          A_i(k) = m; A_j(k) = Ai(y,x+1); A_v(k) = 1; k = k + 1;%A(m,Ai(y,x+1)) = 1;
          A_i(k) = m; A_j(k) = Ai_y_x; A_v(k) = -1; k = k + 1;%A(m,Ai(y,x))   = -1;
          b(m) = vx(y,x);
          m = m+1;
          
          % forwards y
          % s(y+1,x) - s(y,x) = vy(y,x)
          A_i(k) = m; A_j(k) = Ai(y+1,x); A_v(k) = 1; k = k + 1;%A(m,Ai(y+1,x)) = 1;
          A_i(k) = m; A_j(k) = Ai_y_x; A_v(k) = -1; k = k + 1;%A(m,Ai(y,x))   = -1;
          b(m) = vy(y,x);
          m = m+1;
      end
  end
  close(h);
  
  % [[
  % optimization: reduce to actually used size
  %A = A(1:m,:);
  A = sparse(A_i(1:k-1), A_j(1:k-1), A_v(1:k-1));
  b = b(1:m-1); 
  % ]]

  disp('calling least_squares_for...');
  s = least_squares_for(A, b, flat_grayscale_target_image, flat_binary_mask(:) == 1);
  disp('reshaping the result...');
  output_grayscale_image = reshape(s, height, width);
  disp('done');
  
  return
  % debugging
  'A'
  full(A)
  b = b(:);
  b
  
  assert(size(A,1) == m-1);
  assert(length(b) == size(A,1));