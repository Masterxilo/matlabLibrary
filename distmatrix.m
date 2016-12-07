function D = distmatrix(p)
    % computes dist2(p,p), i.e. the pairwise squared distance
    % of a point set
    
    assert(size(p,2) == 2);
    
    n = size(p,1);

    % Compute distance matrix
    D = zeros(n);
    for i=1:n
        for j=1:n
            p1 = p(i,:);
            p2 = p(j,:);
            %p1 - p2;
            D(i, j) = norm(p1 - p2);
            
            assert(i ~= j || D(i,j) == 0); % sanity check
        end
    end
end
    