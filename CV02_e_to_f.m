function F = CV02_e_to_f(E, K)
    % don't support skew matrices K -- just detect that K is the right
    % argument
    assert(size(K,1) == 3 && size(K,2) == 3);
    assert(size(E,1) == 3 && size(E,2) == 3);
    assert(K(2,1) == 0);
    assert(K(3,1) == 0);
    assert(K(1,2) == 0);
    assert(K(1,2) == 0);
    
    Kinv = inv(K);
    F = Kinv' * E * Kinv;
end