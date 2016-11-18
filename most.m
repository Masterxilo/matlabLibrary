function B = most(A)
    % returns an array that has all but the last row and column of A
    % TODO make this work for arrays of any size
    B = A(1:size(A,1)-1,1:size(A,2)-1);