o = CV03_runSift(lena())
assert(~isempty(o.descriptors));
assert(size(o.positions, 2) == 2);
