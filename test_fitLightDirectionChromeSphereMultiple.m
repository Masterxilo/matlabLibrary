close all
[m, i] = CV01_readMaskAndColorImages('ps.chrome');
L = fitLightDirectionChromeSphereMultiple(i, m, true)

assert_equal(size(L), [3 size(i,4)])