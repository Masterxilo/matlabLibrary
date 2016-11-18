function q=sameQ(a,b)
  q = string_sameQ(class(a), class(b)) && allX(a == b);