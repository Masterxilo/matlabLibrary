function F = arrayfun_struct(f, x)
  % applies f to each element of the vector x
  % collecting the results in a struct array. Thus,
  % f must return a struct
  assert(isvector(x));
  assert(isfunction_handle(f));
  
  
  hw = waitbar_start('arrayfun struct in progress');

  i = 1;
  for y = x(:)'
    waitbar(i/length(x), hw);
    F(i) = f(y);
    i = i + 1;
  end
  close(hw);
  assert(length(F) == length(x));
  