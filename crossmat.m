function ax = crossmat(a) 
    % [a]_x: matrix representation of cross product with a on the left, i.e.
    % the linear function "a x *"
    assert(length(a) == 3);
    assert(isreal(a)); assert(isdouble(a));
    ax = [0 -a(3) a(2);a(3) 0 -a(1);-a(2) a(1) 0];
