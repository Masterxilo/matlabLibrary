function s = string_most(s)
  % drop last char of string s
  assert(stringQ(s));
  s = s(1:end-1);
  