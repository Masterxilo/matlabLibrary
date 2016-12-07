f = @(x,y) sqrt([x;y]);
assert_equal(arrayfun2(f,[1 9],[16 25]), [
  1     3
  4     5
]);