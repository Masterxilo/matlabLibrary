function A = read_mtx_file(filename)
  % reads a sparse matrix from an mtx file as written by Mathematica
  % (for a Sparse Array) and cs_dump_mtx.
  
  % this does basically the same as cs_undump_mtx
  f = fopen(filename, 'rb');
  
  % skip initial comments
  fgetl(f);
  fgetl(f);
  
  t = fscanf(f, '%u', 3);
  m = t(1); n = t(2); nnz = t(3);
  data = zeros(nnz,1); is = zeros(nnz,1); js = zeros(nnz,1); k = 1;
  
  for i=1:nnz
    t = fscanf(f, '%u', 2); i = t(1); j = t(2);
    data(k) = fscanf(f, '%f', 1);
    assert(i >= 1 && i <= m);
    assert(j >= 1 && j <= m);
    is(k) = i; js(k) = j;
    
    k = k + 1;
  end
  
  fclose(f);
  
  A = sparse(is, js, data);