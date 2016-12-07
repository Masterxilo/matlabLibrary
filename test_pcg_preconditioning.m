%% This document covers the
%   shouldConvergeJ/b
% sparse matrix and vector Fixtures data
% that have, without preconditioning, bad convergence 
% when using the ConjugateGradientMethod.
% c.f. 'cg bad convergence.nb'
%
% These equations arise with weights {10,1,1,1} in 
% "coarse to fine scene 1.nb" on the coarsest level.

% Load the matrices and set the stage for later solution attempts.
j = read_mtx_file('shouldConvergeJ.mtx');
b = csvread('shouldConvergeb.Table.txt');

% to normal equations:
% doing this explicitly is a bad idea, numerically
[jn, bn] = normal_equations_conversion(j, b);
jt = j';

tol = 1e-6; maxit = size(jn,1); % don't care about iteration count for now

%% A \ b does good, pcg without preconditioner not
% Note: linear_solve_error computes the error in the norm between A*x and b
% linear_solve_error2 includes the maxabsdiff

sbad = pcg(jn, bn, tol,maxit, []); % allow many iterations, no preconditioner
disp(['pcg error ' num2str(linear_solve_error2(jn, bn, sbad))]);

% using a function that computes jt.j.x comes ... not better? But it does
% in mathematica.. shouldn't this behave better, numerically?
s = pcg(@(x) jt * (j * x), bn, tol,maxit, []); % allow many iterations, no preconditioner
disp(['pcg functional error ' num2str(linear_solve_error2(jn, bn, s))]);

% try to pick a good preconditioner -- the default choice (is there one?) does not do
% better than none at all


sgood = jn \ bn; 
disp(['\ error ' num2str(linear_solve_error2(jn, bn, sgood))]);

%% lsqr does poorly?!
sgood = lsqr(jn, bn); 
disp(['sgood error ' num2str(linear_solve_error2(jn, bn, sgood))]);

%% gmres poor
sgood = gmres(jn, bn); 
disp(['sgood error ' num2str(linear_solve_error2(jn, bn, sgood))]);

%% gmres with ilu does good
% nofill not so much
[L,U] = ilu(jn,struct('type','ilutp','droptol',1e-6));
s = gmres(jn, bn,[], tol,maxit,L,U);
disp(['gmres error ilutp ' num2str(linear_solve_error2(jn, bn, s))]);

[L,U] = ilu(jn,struct('type','crout','droptol',1e-6));
s = gmres(jn, bn,[], tol,maxit,L,U);
disp(['gmres error crout ' num2str(linear_solve_error2(jn, bn, s))]);

[L,U] = ilu(jn,struct('type','nofill','droptol',1e-6));
s = gmres(jn, bn,[], tol,maxit,L,U);
disp(['gmres error nofill ' num2str(linear_solve_error2(jn, bn, s))]);

%% <pcg> (not gmres) with ilu (ilutp) does good
% though a bit worse than gmres.
%
% We can find the source code for ilutp in the Octave source code...
% Michael Zollhöfer said they used a block-diagonal preconditioner, but 
% I cannot find the details.

[L,U] = ilu(jn,struct('type','ilutp','droptol',1e-6));
s = pcg(jn, bn, tol,maxit,L,U);
disp(['pcg error ilutp ' num2str(linear_solve_error2(jn, bn, s))]);

[L,U] = ilu(jn,struct('type','crout','droptol',1e-6));
s = pcg(jn, bn, tol,maxit,L,U);
disp(['pcg error crout ' num2str(linear_solve_error2(jn, bn, s))]);

%% minres poor
sgood = minres(jn, bn); 
disp(['sgood error ' num2str(linear_solve_error2(jn, bn, sgood))]);


%%
s = pcg(jn, bn, tol,maxit); % allow many iterations
disp(['sgood error ' num2str(linear_solve_error2(jn, bn, s))]);

%% Cannot use ichol?! 'Negative pivot'...
L = ichol(jn);
linear_solve_error2(jn, bn, ...
   pcg(jn, bn, tol,maxit, L, L') ...
)