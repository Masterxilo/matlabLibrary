function B = kernelNormalize(A)
    % make total(A) == 1
    B = A / total(A);