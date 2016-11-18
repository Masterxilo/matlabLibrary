function assert_approximately_equal(A,B)
    assert(norm(A(:) - B(:)) < 10^-4);