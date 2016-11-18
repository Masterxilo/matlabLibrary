function assert_equal(A, B)
    assert_same_size(A, B);
    assert(all(A(:) == B(:)));