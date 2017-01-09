function y = uint16toUnorm(x)
  assert_class(x, 'uint16');
  y = double(x) / (2^16-1);