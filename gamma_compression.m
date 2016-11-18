function gamma_compression(alpha, beta, g)
    % simple gradient-scaling strategy, useful for highlight-removal
    % together with poisson reconstruction
    %
    % run this on each gradient of the region where highlights should be
    % removed
    %
    % alpha^beta norm(g)^(-beta) g
    
    % TODO