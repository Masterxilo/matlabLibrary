function str2file(string, filename)
%write a single string to a file  
assert(isrow(string));
  assert(ischar(string));
  
  f = fopen(filename, 'wb');
  %assert(~ferror(f));
  fprintf(f, '%s', string);
  fclose(f);