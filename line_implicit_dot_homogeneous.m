function line_implicit_dot_homogeneous(rows, cols, y)
    % Draw the line of all homogeneous normalized points x with dot(y, x) = 0
    % within the current bounds of the image with size rows x cols.
    %
    % y * x == 0 <-> y * [u v 1] == 0 <-> y(1)u + y(2)v = -y(3)

    assert(length(y) == 3);
    assert(rows > 0);
    assert(cols > 0);
    assert(isreal(rows) && isreal(cols));   
    
    u = @(v) 1/y(1) * (-y(3) - y(2)*v);
    v = @(u) 1/y(2) *  (-y(3) - y(1)*u);
    
    % find the solutions p with fixed u or v.
    line([1, cols], [v(1), v(cols)]);
    line([u(1), u(rows)], [1, rows]);
   