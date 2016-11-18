function q = all2(A)
    % whether all entries in a 2-d logical matrix are true
    assert(dimension(A) == 2);
  q = all(all(A));