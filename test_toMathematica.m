o = struct(); o.x = 0;
assert_equal(toMathematica(o), '<|"x"->0.00000000000000000|>');

assert_equal(toMathematica(0), '0.00000000000000000');
assert_equal(toMathematica('0'), '"0"');
assert_equal(toMathematica([1 2 3]), '{1.0000000000000000,2.0000000000000000,3.0000000000000000}');
assert_equal(toMathematica(eye(2)),'{{1.0000000000000000,0.00000000000000000},{0.00000000000000000,1.0000000000000000}}');

assert_equal(toMathematica(pi),'3.1415926535897931');
assert_equal(toMathematica(10^40),'1.0000000000000000*^+40');
assert_equal(toMathematica(2^400), '2.5822498780869086*^+120');
'ok'