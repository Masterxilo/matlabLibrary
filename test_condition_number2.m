A = read_mtx_file('ConjugateGradientMethodFailureExample2A.mtx');
size(A)
condition_number(full(A)) % must be full