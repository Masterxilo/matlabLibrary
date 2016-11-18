function q = isdouble(x)
  q = string_sameQ(class(x), 'double');