function B = fliplrud(A)
  % fliplr and ud, mirroring along both axis, such that
  % B(i,j) = A(h-i+1, w-j+1)
  B = fliplr(flipud(A));