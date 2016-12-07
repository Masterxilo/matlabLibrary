function q = approximately_equal(A,B,epsilon)
  % whether norm of difference between A and B differs by less than epsilon
  % which defaults to 10^-4
  %A
  %B
  if nargin == 2
    epsilon = 10^-4;
  end
  q = norm(A(:) - B(:)) <= epsilon;