function q = isfile(filename)
  f = fopen(filename, 'rb');
  if f < 0
    q = false;
  else
    q = true;
    fclose(f);
  end