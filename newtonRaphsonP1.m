function i = newtonRaphsonP1(theta0) 
  % Looking at which zero this function converges to using the
  % newton-raphson method gives a nice fractal.
  %
  % this returns the index 1 to 3 of the root we find.
  %
  % Total, pure function
  %
  % Implemented for Probabilistic algorithms, c.f. pa_p2_ext
  
    Jgi = @(x) [...
(x(1)^2-x(2)^2)/(3 *(x(1)^2+x(2)^2)^2),...
(2 *x(1)* x(2))/(3 *(x(1)^2+x(2)^2)^2)...
;
-((2* x(1)* x(2))/(3 *(x(1)^2+x(2)^2)^2)),...
(x(1)^2-x(2)^2)/(3 *(x(1)^2+x(2)^2)^2)...
];


    g = @(x) [x(1)^3 - 3 *x(1)* x(2)^2 - 1;3 *x(1)^2 *x(2) - x(2)^3];
    
    thetak = newtonRaphson(theta0, g, Jgi);
    
    i = -1;
    z1 = [1;0]; z2 = [-0.5;sqrt(3)/2]; z3=[-0.5;-sqrt(3)/2];
   if norm(thetak - z1) < 0.01
           i = 1;
   elseif norm(thetak - z2) < 0.01
           i = 2;
   elseif norm(thetak - z3) < 0.01 
           i = 3;
   end
    
end