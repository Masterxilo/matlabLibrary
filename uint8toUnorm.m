function y = uint8toUnorm(x)
  assert_class(x, 'uint8');
  y = double(x) / (2^8-1);