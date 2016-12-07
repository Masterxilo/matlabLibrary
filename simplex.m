function x = simplex(d, A, b)
% Solves the linear programming problem:
% x = argmin_{x \in {x : Ax <= b & x >= 0}} <d, x>
%
% Programmed for probabilistic algorithms class.
%
% Disclaimer: I do not fully understand how or why this works.
% Understanding it can fill a whole course:
% https://www.math.washington.edu/~burke/crs/407

    x = b;
    n = size(A,2);    
    m = size(A,1);
    assert(length(b) == m);
    sigma = 1:(n+m);
    
    % STEP 0 Set up tableau
    theta = 0;
    r = -1; s = -1;
    T = [A b'; d theta];
    sc = []; ais = [];
    assert(all(size(T) == [m+1, n+1]));
    
    while any(d < 0) % STEP 1, stopping condition
        
       
        
        % STEP 2 Select pivot column
        ds = T(m+1,1:n);
        [~, s] = min(ds);
        if ds(s) >= 0
            break; % we found the solution, cannot become even smaller
        end
        
        ais = reshape(T(1:m, s), 1, m);
        
        % STEP 3, no finite solution
        if all(ais <= 0)
            x = repmat(inf, 1, n);
            return;
        end
        
        % Compute row selection criterion column
        sc = b ./ ais;
        
        % STEP 4 Select pivot row        
        bi_ais = min(sc(ais > 0));
        % Find where that was
        r = find(sc == bi_ais);
        r = r(1);
        
        
        % STEP 5 Refresh the tableau
       
        % aij
        A = T(1:m, 1:n); % for syntax
        Anew = A; % need unchanged versions
        ars = A(r, s);
        if false % attempt to do without loops
            % i ~= r, j == s
            Anew(:,s) = -A(:,s)/ars;
            % i == r, j ~= s
            Anew(r,:) = A(r,:)/ars;
            Anew(r,s) = 1/ars;
        end
        for i = 1:m
            for j = 1:n
                if i ~= r && j ~= s
                    Anew(i,j ) = A(i,j) - A(i,s)*A(r,j)/ars;
                elseif i == r && j == s
                    Anew(i,j) = 1/ars;
                elseif i ~= r && j == s
                    Anew(i,j) = -A(i,s)/ars;
                elseif i == r && j ~= s
                    Anew(i,j) = A(r,j)/ars;
                end
            end
        end
        
        T(1:m, 1:n) = Anew;
        
        % b
        b = reshape(T(1:m,1+n),1,m);
        br = b(r);
        for i=1:m
            if i ~= r
                b(i) = b(i) - br*A(i,s)/ars;
            else
                b(i) = br/ars;
            end
        end
        T(1:m,1+n) = b;
        
        % dj
        d = T(1+m,1:n);
        ds = d(s);
        for j=1:n
            if j ~= s
                d(j) = d(j) - ds*A(r,j)/ars;
            else
                d(j) = -ds/ars;
            end
        end
        T(1+m,1:n) = d;
        
        % theta
        theta = T(1+m,1+n);
        theta = theta + ds * br/ars;
        T(1+m,1+n) = theta;
        
        % STEP 6
        sigma([s n+r]) = sigma([n+r s]);
        
        A = Anew;
    end
    
    if false % debug
     'before iteration'
        T
        A
        b
        d
        ais
        sc
        [r s]
        sigma
        pause
    end
    % Set output
    x(sigma) = [zeros(1,n) b];
    % Cut off part we don't care about (slack variables)
    x = x(1:n);
end