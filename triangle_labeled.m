function triangle_labeled(points)
    % points is nx2
    % like triangle, but labels the vertices with their index
    triangle(points);
    i = 1;
    for point=points'
        point
        text(point(1), point(2), num2str(i),'Color','r');
        i = i+1;
    end