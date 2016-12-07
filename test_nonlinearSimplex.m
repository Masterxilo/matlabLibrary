% P1

%% 2D, visualized examples

iterations = 30;

%% Zero at 0,0
L = @(x) norm(x)
[Lt_min, theta_min] = nonlinearSimplex(2,L,iterations,true)

%% Zeros at 1 0 and 0 1
L = @(x) norm(x-[1 0])*norm(x-[0 1])
[Lt_min, theta_min] = nonlinearSimplex(2,L,iterations,true)

%% The p-dimensional function, for p even,
% as given in the exercise (this is quite a boring function, with a single
% minimum 0 at 0).
%
% But at least it can be used to test the algorithm for any dimension.

p = 6;

iterations = 500;
if p == 2 
    iterations = 30;
end

B = diag(repmat(1,1,p))*0.5 + ones(p)*0.5
L = @(x) sum(x(1:p/2).^4) + x * B * (x');

[Lt_min, theta_min] = nonlinearSimplex(p,L,iterations,p==2)



