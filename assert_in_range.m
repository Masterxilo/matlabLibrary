function assert_in_range(xs, minInclusive, maxInclusive)
    % tests for any array whether all elements are in the range
    % [minInclusive, maxInclusive]
    assert(allX(xs >= minInclusive));
    assert(allX(xs <= maxInclusive));