function E = CV02_f_to_e(F,K)
    assert(size(K,1) == 3 && size(K,2) == 3);
    assert(size(F,1) == 3 && size(F,2) == 3);
    assert(K(2,1) == 0);
    assert(K(3,1) == 0);
    assert(K(1,2) == 0);
    assert(K(1,2) == 0);
    
    E = K' * F * K;
end