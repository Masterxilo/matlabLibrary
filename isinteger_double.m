function q = isinteger_double(x)
  % whether x contains only integral values
  %
  % In that case, conversion to int, floor and ceil will not lose
  % information (they will be invertible, i.e. injections)
  %
  % Note that very large doubles are all integers (namely once
  % the mantissa is shorter than the exponent is large), but
  % at that point not all integers are representable anymore.
  q = isdouble(x) && allX(floor(x) == x);