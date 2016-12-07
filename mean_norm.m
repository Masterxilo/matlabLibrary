function m = mean_norm(x)
    % computes the mean of the norm of each vector in the
    % d x n matrix x of points

    n = size(x,2);
    
    % TODO vectorize
    m = 0;
    for i=1:n
        m = m + norm(x(:,i));
    end
    m = m/n;