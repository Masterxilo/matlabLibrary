function H = homography2d_impl2(p, q)
  % implementation according to rectification.nb research
  % c.f. P8085
  
  n = size(p,2);
    
  A = zeros(n*3, 9 + n); % n*3 equations, 9 + n unknowns (H and lambdas)
  k = 1; % counter for equations
  
  % H = [ha;hb;hc]
  
  for i=1:n
    pi = [p(:,i);1];
    qi = [q(:,i);1];
    
    % pi^T . ha - qix lambda_i = 0
    A(k, 1:3) = pi;
    A(k, 9+i) = -qi(1);
    k = k+1;
    
    % pi^T . hb - qiy lambda_i = 0
    A(k, 4:6) = pi;
    A(k, 9+i) = -qi(2);
    k = k+1;
    
    % pi^T . hc - 1 lambda_i = 0
    A(k, 7:9) = pi;
    A(k, 9+i) = -qi(3); % == -1
    k = k+1;
  end
  
  assert(k-1 == 3*n);
  %A % debug here
  
  mask = ones(9+n,1); mask(1) = 0; % don't solve for h(1,1)
  h_lambda = least_squares_for(A, zeros(3*n,1), ones(9+n,1), mask == 1);
  
  h = h_lambda(1:9);
  H = reshape(h,3,3)';
  
  