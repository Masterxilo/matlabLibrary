r = face1();
r = r(:,:,1);

assert(min(min(r)) >= 0);
assert(max(max(r)) <= 1);

r = face1_1000(); % uses imresize_padding
r = r(:,:,1);

min(min(r))

assert(min(min(r)) >= 0);

max(max(r))-1 % used to be nonzero without clamp01...
assert(max(max(r)) <= 1);