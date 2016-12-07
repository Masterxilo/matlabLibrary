function x = condition_number(A)
  % 2-norm condition number of matrix
  %if 
   % condest
  % A must be a full matrix for cond -- condest only works on square
  % matrices -- cond implementation will still try to use it for sparse matrices!
  
  x = cond(A); 
  return;
  % this gives a different result with ConjugateGradientMethodFailureExample2A
  [~,s,~] = svd(full(A));
  ss=diag(s);
  x = ss(1)/ss(length(ss));