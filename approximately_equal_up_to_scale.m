function q = approximately_equal_up_to_scale(A,B,epsilon)
  % same as approximately_equal_up_to_scale, but first scales the maximum
  % element of the two to 1
  if nargin == 2
    epsilon = 10^-4;
  end
  A = abs(A);
  B = abs(B);
  q=approximately_equal(A/maxX(A), B/maxX(B), epsilon);