% from my CV02 report, P8132

E = [0.1198 0.2029 0.4486
0.6995 0.0338 2.6887
-0.0639 -2.5284 -0.0027];

[t,R] = decomposeEssentialMatrix(E);

assert_approximately_equal(t, [    2.6326
   -0.4386
    0.2054]);
assert_approximately_equal(R, [
    0.9361    0.1399   -0.3228
   -0.1346    0.9901    0.0388
    0.3251    0.0071    0.9457
    ]);
