function minid = dist2nearest(a, b)
% Finds the closest element in b for each element in a.
%
% In:
% a     n x d
% b     k x d
% Out:
% minid 1xn: for each row in a the index of the closest in b 

    dist = dist2(a, b);
    minid = [];
    for i=1:size(a,1)
        [~, j] = min(dist(i,:));
        minid = [minid j];
    end
end