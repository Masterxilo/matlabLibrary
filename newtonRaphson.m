function x = newtonRaphson(x0, g, Jgi) 
  % Implements the newton-raphson root finding method
  % g is a function R^n -> R^m, Jgi is the corresponding jacobian
  % x0 is the initial guess
  %
  % steps along the gradient in full sized steps (this might not be
  % ideal...) to find the root.
  %
  % Implemented for Probabilistic Algorithms
  
    x = x0;
    xp = x0 + ones(length(x0),1);
    
    while norm(x-xp) > 0.01
        xp = x;
        
        % 
        x = x - Jgi(x)*g(x);
    end
    
end