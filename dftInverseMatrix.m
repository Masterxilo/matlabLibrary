function A = dftInverseMatrix(M)
    r = 0:M-1;
    A = r' * r;
    A = exp(2 * pi * i * A / M);