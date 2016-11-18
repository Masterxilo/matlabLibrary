x = 0; % stands for unknown or unneeded values

% Example from the lecture
data = [2,4,4,x,x,x,4];
derivatives = [x,x,1,2,-1,0]; 
best_fit_data = solve_poisson_equation_1d(data, derivatives, data == x, 20)

% desired missing values obtained via LeastSquares in Mathematica
% or [1 0 0;-1 1 0;0 -1 1;0 0 -1]\[5 2 -1 -4]'
assert_approximately_equal(best_fit_data, [2,4,4, 4.5, 6., 4.5 ,4]); 

% Example from the exercise slides
source_data = [3,5,4,4,3]
derivatives = forward_differences(source_data)
mask = [false, true, true, true, false];
data = [4,5,5,3,2];
best_fit_data = solve_poisson_equation_1d(data, derivatives, mask, 20)

assert_approximately_equal(best_fit_data, [4,5.5,4,3.5,2]);
