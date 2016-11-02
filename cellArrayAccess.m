function B = cellArrayAccess(A, x)
    % B = cellArrayAccess(A, x)
    % A is an array
    % x is a 1-dimensional cell giving indices into A
    % A is accessed as if you used A(x...) with each element of x
    % separated by ,
    %
    % thus cellArrayAccess(A, {1:2, 3:5}) === A(1:2, 3:5)
    %
    % TODO finish implementation, scanCellTuples might help
    
    assert(length(x) == length(size(A)));
    
    B = zeros