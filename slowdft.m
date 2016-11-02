function F = slowdft(f)
    f = f(:);
    M = length(f);
    F = dftMatrix(M) * f;

    