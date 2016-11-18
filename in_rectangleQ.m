function q = in_rectangleQ(p, min, size) 
  q = all(p >= min) && all(p < min+size);