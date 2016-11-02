function A = dftMatrixNormalized(M)
    A = dftMatrix(M) / sqrt(M);