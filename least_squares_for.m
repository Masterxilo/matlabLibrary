function output_list = least_squares_for(A, b, target_list, binary_mask)
  % solve Ax = b but solving only for those x where binary_mask is true,
  % keeping the rest as they are in target_list
  %
  % for educational purposes 
  
  assert(ismatrix(A));
  assert(isreal(A));
  assert(isreal(b));
  assert(islogical(binary_mask));
  n = length(target_list);
  assert_equal(size(A), [length(b) n]);
  assert(length(binary_mask) == n);
  b = b(:); % make b column vector

  if n > 1000
    disp(['least_squares_for preparation...' num2str(n)]);
  end
  % fix the variables that are not unknown by moving them to the right side
  
  %for i=find(binary_mask == 0)'
  %  assert(isrealnumber(i));
    % move this column of A to the other side
  %  b = b - target_list(i) .* A(:,i);
  %end
  % [[ equivalently
  ind = find(binary_mask == 0)'; % does it really matter if this is a row?
  target_list = target_list(:); % make sure this is a column
  
  b = b - A(:,ind) * target_list(ind);
  % ]]
  
  
  % remove these columns from A
  A = A(:,binary_mask);

  % solve the least squares problem
  if n > 1000
    disp(['least_squares_for solving ' num2str(size(A)) ', sparse?: ' num2str(issparse(A))]);
  end
  sol = A\b;

  % insert the rest
  output_list = target_list;
  output_list(binary_mask) = sol;