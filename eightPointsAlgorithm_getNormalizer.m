
function T = eightPointsAlgorithm_getNormalizer(x)
% Inputs: 
%               x      3xN     normalized* homogeneous coordinates of points
% Output: T 3x3 homogeneous transform that centers x around the centroid
% and makes mean squared distance to this origin 2.

    n = size(x,2);
    assert(size(x,1) == 3);
    
    c = [centroid_dn(x(1:2,:)) ; 1]; % homogeneous centroid of points
    
    % compute m = mean squared distance to c
    m = meansqr_norm(x - repmat(c, 1, n));
    
    % Scale all distances by 
    s = sqrt(2) / sqrt(m);
    % Such that m becomes 2
    
    % T moves by -c and then scales by s (note the order):
    T = [
        s 0 0
        0 s 0
        0 0 1
        ] * [
        1 0 -c(1)
        0 1 -c(2)
        0 0 1
        ];
    
    % [
    % Test: recomputing the mean squared distance now (after computing T * x) should give 2
    % and the centroid should now come out as 0.
    if false % use true to enable post-condition test
      y = T * x;
      assert_approximately_equal(centroid_dn(y(1:2,:)), [0,0]);
      assert_approximately_equal(meansqr_norm(y(1:2,:)), 2);
    end
    % ]