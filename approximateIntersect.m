function p = approximateIntersect(v1, o1, v2, o2) 
    % approximateIntersect(v1, o1, v2, o2) 
    % find the midpoint between closest points on the two lines defined by
    %   o1 + t v1
    %   o2 + t v2
    %
    % c.f. lec06_epipolar.pdf Slide 7
    %
    % all inputs are row vectors
    %
    %
    assert(isrow(v1));
    assert(isrow(o1));
    assert(isrow(v2));
    assert(length(v2) == length(v1));
    assert(length(o1) == length(v1));
    
    if nargin < 4
        o2 = zeros(1,length(v1));
    end
    assert(length(o2) == length(o1));
    assert(isrow(o2));

    dist = @(t) norm((t(1)*v1 + o1) - (t(2)*v2 + o2));
    x = fminsearch(dist,[1 1]);
    t1 = x(1);
    t2 = x(2);
    p = mean([v1*t1+o1;v2 * t2 + o2]);
    % TODO should we only allow positive t?
    % Nah, the algebraic solution supports intersections behind the cam too