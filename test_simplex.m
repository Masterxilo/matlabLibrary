% test simplex
d = [-1 -2];
A = [1 0;1 1;-1 1];
b = [4 6 1];

x = simplex(d, A, b)
A*x'
b
x >= 0
A*x' <= b'
d * x'