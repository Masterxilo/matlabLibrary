assert(bilinear_interpolate_multiple([0 2;1 3], [1.5;1.5]) == [(0+2+1+3)/4]);
assert(bilinear_interpolate_multiple([0 2;1 3], [1;1])==0)
assert(bilinear_interpolate_multiple([0 2;1 3], [2;1])==2)
assert(bilinear_interpolate_multiple([0 2;1 3], [1;2])==1)
assert(bilinear_interpolate_multiple([0 2;1 3], [2;2])==3)

% all at once
assert_equal(bilinear_interpolate_multiple([0 2;1 3], [
    1.5 1 2 1 2
    1.5 1 1 2 2
    ]), [(0+2+1+3)/4 0 2 1 3])

% multichannel
i = [];
i(:,:,1) = [0 2;1 3];
i(:,:,2) = [0 2;1 3];

assert_equal(bilinear_interpolate_multiple(i, [
    1.5 1 2 1 2
    1.5 1 1 2 2
    ]), repmat([(0+2+1+3)/4 0 2 1 3],2,1))
