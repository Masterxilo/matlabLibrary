assert(isRowVector([1 2]')==0);
assert(isRowVector([1 2])==1);
assert(isColumnVector([1 2])==0);
assert(isColumnVector([1 2]')==1);
assert(isColumnVector([1 2]')==1);
assert(norm(naiveCircularBoxFilter(eye(3), 3)-ones(3)/3) == 0);
assert(all(all(rescale01(2*eye(3)) == eye(3))));
assert(arrayProduct([1 2]) == 2);
assert(cconv2(eye(3), ones(3)) == ifft2(fft2(eye(3)) .* fft2(ones(3))));
assert(fliplrud([1 2;3 4]) == [4 3;2 1]);
assert(fliplrudQ([1 2;3 4], [4 3;2 1]));
assert(fliplrud([1 2;3 4]) == rot180([1 2;3 4]));
h = rand(3);
assert(fliplrudQ(h,fliplrud(h)));