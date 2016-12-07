function triangle(points)
    % uses line to draw a triangle
    % points is a 3x2 matrix containing the 2d coordinates
    %
    % equivalent to polygon(points)
    %
    
    m = [points' points(1,:)'];
    line(m(1,:), m(2,:))