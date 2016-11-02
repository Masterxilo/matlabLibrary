function b = movingAverageCircularVector(a, n)
  % b = movingAverageCircularVector(a, n)
  % a   a vector
  % n an odd number less than or equal to the length of a
  %
  % b will be a vector of the same size as a
  %
  % Computes an n-moving average in the vector a interpreted circularly
  % along the first dimension.
  
  assert(length(size(a)) == 2);
  assert(n <= length(a));
  assert(mod(n,2) == 1);
  assert(n >= 3);
  
  radius = (n-1)/2;
  
  length_a = length(a);
  
  elements = circshift(a, [0, radius]);
  elements = elements(1:n);
  average = mean(elements);
  
  b = zeros(size(a));
  
  for i=1:length_a
    b(i) = average;
    
    % prepare next by shifting
    average = average - elements(1)/n;
    
    elements = circshift(elements, [0, -1]);
    elements(n) = a(wrapN(i+radius+1, length_a));
    
    average = average + elements(n)/n;
  end
  
  
  
  