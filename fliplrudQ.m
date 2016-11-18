function q = fliplrudQ(A, B)
  % whether fliplrud(A) == B, only for matrices
  if any(size(A) ~= size(B))
    q = false;
  else
    w = matrixWidth(A);
    h = matrixHeight(A);
    
    q = true;
    for i=1:h
      for j=1:w
        q = q && (B(i,j) == A(h-i+1, w-j+1));
      end
    end
    
  end