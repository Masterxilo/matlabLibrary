assert(isRowVector([1 2]')==0);
assert(isRowVector([1 2])==1);
assert(isColumnVector([1 2])==0);
assert(isColumnVector([1 2]')==1);
assert(isColumnVector([1 2]')==1);
assert(norm(naiveCircularBoxFilter(eye(3), 3)-ones(3)/3) == 0);
assert(all(all(rescale01(2*eye(3)) == eye(3))));
