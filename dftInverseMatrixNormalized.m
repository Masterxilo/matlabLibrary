function A = dftInverseMatrixNormalized(M)
    A = dftInverseMatrix(M) / sqrt(M);