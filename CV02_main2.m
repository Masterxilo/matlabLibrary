% Computer Vision project 2 part 2, c.f. P8129

close all


%% Images with known corresponding points
left = imreaddouble('bs.left.jpg');
right = imreaddouble('bs.right.jpg');

A=load('bs.Matched_Points.txt');
[M N] = size(A);

leftPoints = [A(:,3)'; A(:,4)'; ones(1,M)];
rightPoints = [A(:,1)'; A(:,2)'; ones(1,M)];

points = size(leftPoints,2); % count

%% Show images
% Note that point coordinate system is flipped relative to the image
% That doesn't need to bother us further
close all
figure()

subplot(1,2,1);
imshow(left);
title('Left Image');
hold on
scatter(leftPoints(1,:),leftPoints(2,:),'.')


subplot(1,2,2);
imshow(right);
title('Right Image');
hold on
scatter(rightPoints(1,:),rightPoints(2,:),'.')




%% Eight points algorithm on all points
% Let Left camera = camera 1 (points x1)
% Right camera = camera 2
% F = F^1_2, i.e. x2' * F^1_2 * x1 = 0
F = eightPointsAlgorithmImpl2(leftPoints,rightPoints) % Impl1|2
% Equivalently
%Method: LMedS (default) | Norm8Point | RANSAC | MSAC | LTS
%F = estimateFundamentalMatrix(leftPoints([1 2],:)',rightPoints([1 2],:)',...
%    'Method','Norm8Point')

eigsF = eig(F) % eigenvalues check of F... should these be (1 0 0) ?

%% Epipolar constraint check
for i=1:points
    assert(abs(rightPoints(:,i)' * F * leftPoints(:,i)) < 0.03); % error should be small
end

disp('epipolar constraint with fundamental matrix ok');


%% Load intrinsic camera calibration
% note that we need to integrate the focal lengths, they are not yet part
% of the matrix
K = o.K * [o.fl 0 0;0 o.fr 0;0 0 1];
Kinv = inv(K);

%% Compute Essential Matrix (Question 1)
E = CV02_f_to_e(F,K)

% Epipolar constraint check
normalize = @(v) [[v([1 2])/v(3)];1];
for i=1:points
    assert(abs(...
        normalize(Kinv * rightPoints(:,i))' * ...
        E * ...
        normalize(Kinv * leftPoints(:,i))) < 0.03);
end
disp('epipolar constraint with essential matrix ok');

%% Decompose
[t,R] = decomposeEssentialMatrix(CV02_f_to_e(F,K)) 

% Four cases: Both R and t can swap sign, projection could be from the
% back!
%R = -R;
%t = -t; % this is always also a valid solution - how do we know which is
%right? They are both!

% Sanity checks
% E := [t]_x R = crossmat(t) * R
decomposedE = crossmat(t) * R;
decomposedF = CV02_e_to_f(decomposedE,K);
assert(norm(E - decomposedE) < 8);

% Epipolar constraint check
for i=1:points    
    assert(abs(...
        normalize(Kinv * rightPoints(:,i))' * ...
        decomposedE * ...
        normalize(Kinv * leftPoints(:,i)) ...
        ) < 0.45); 
end

disp('epipolar constraint with decomposed essential matrix ok');

%% Projection matrices, such that 
% x1 = K * m1 = K * P1 * X1
% x2 = K * m2 = K * P2 * X1
P = [1 0 0 0;0 1 0 0;0 0 1 0]; % canonical/normalized projection
P1 = P;
P2 = P * [R t;0 0 0 1]; % P2 includes relative rotation and translation (extrinsic parameters

assert(size(P1,1) == 3);
assert(size(P1,2) == 4);
assert(size(P1,1) == size(P2,1) && size(P1,2) == size(P2,2));

%% Test projecting some point to both cameras
% Check that some point Y1, expressed in camera 1 coords,
% projects to expected epipolar coords/line in the two images
Y1 = [-50+rand()*100 -50+rand()*100 100]'; % in C1's coordinates

m1 = normalize(P1 * [Y1;1]); 
m2 = normalize(P2 * [Y1;1]);
% Error with original E and F
assert(m2' * E * m1 < 0.1);
assert((K*m2)' * F * (K*m1) < 0.1);
% The projections were contstructed for these E and F, actually...
% so the error is nothing
assert(abs( m2' * decomposedE * m1) < 1e-10);
assert(abs( (K*m2)' * decomposedF * (K * m1)) < 1e-10);
disp('projection test 1 ok');

% Reconstruct the point x (as y) such that it is consistent with the two
% projections (in normalized cam coords, not pixel coords!)

% lambda1 m1 = P1 X for some lambda1
% This means that m1 and P1 X are colinear -- equivalently, 
% m1 cross P1 X = 0

% We need to solve
% crossmat(m1)*P1 * X = 0
% crossmat(m2)*P2 * X = 0
% A * X = 0
A = [crossmat(m1)*P1;crossmat(m2)*P2];
assert(size(A,1) == 6);
assert(size(A,2) == 4);
    
% X = [x y z 1], bring to other side!
b = -A(:,end);
A = A(:,1:end-1);
assert(size(A,2) == 3);

X1 = A\b; % X in C1's space
assert(norm(X1 - Y1) < 1e-6);

% Geometric approach, X in C2's space:
X2 = approximateIntersect((R*m1)',t', m2')';
X1 = inv(R)*(X2-t); % Back to C1's space
assert(norm(X1 - Y1) < 1e-3); % inverse is not so accurate

disp('projection test 2 ok');

%% Reconstrct the 3D points (Question 3)
useGeometricApproach = true;

% We want to intersect the two visual rays
%corresponding to x1 and x2, but because of
%noise and numerical errors, they don’t meet
%exactly 
allX = [];
allM = [];
allM2 = [];

% detect situation where not all points are either in front of
% Or behind camera 1. This can happen when the rotation matrix
% is turned 90° around some axis. -- this should be fixed by the
% "plausible axis" fix in decomposeE...

lastZ = 0;
for i=1:points
    disp(['computing point locations' num2str(i) '/' num2str(points)])
    
    % to normalized cam coords
    x1 = leftPoints(:,i);
    x2 = rightPoints(:,i);
    m1 = normalize(Kinv*x1);
    m2 = normalize(Kinv*x2);
    allM = [allM m1];
    allM2 = [allM2 m2];
    
    
    % lambda1 x1 = P1 X for some lambda1
    % This means that x1 and P1 X are colinear -- equivalently, 
    % x1 cross P1 X = 0
    
    if useGeometricApproach
      % Geometric approach, X in C2's space: -- same result
      X2 = approximateIntersect((R*m1)',t', m2')';
      X = inv(R)*(X2-t); % Back to C1's space
    else
      % Algebraic solution:
      % We need to solve
      % crossmat(x1)*P1 * X = 0
      % crossmat(x2)*P2 * X = 0
      % A * X = 0

      A = [crossmat(m1)*P1;crossmat(m2)*P2];
      assert(size(A,1) == 6);
      assert(size(A,2) == 4);

      % X = [x y z 1], bring to other side!
      b = -A(:,end);
      A = A(:,1:end-1);
      assert(size(A,2) == 3);

      X = A\b;
    end
      
    assert(X(3) ~= 0 && (lastZ == 0 || sign(X(3)) == sign(lastZ)));
    lastZ = X(3);
    
    allX = [allX X];
    
    % Verify error
    m1p = normalize(P1*[X;1]);
    m2p = normalize(P2*[X;1]);
    reproj_err = norm(m1-m1p) + norm(m2-m2p); % reprojection error, should be small
    assert(reproj_err < 0.5);
    assert(abs(m2p' * E * m1p) < 0.2);
    
    % reprojection error in pixels -- if this becomes too large
    % R is probably wrong!
    x1p = normalize(K*P1*[X;1]);
    x2p = normalize(K*P2*[X;1]);
    reproj_err_pix = norm(x1-x1p) + norm(x2-x2p); % reprojection error, should be small <- turns out bad with eightPointAlgorithmImpl1, ok with 2
    assert(reproj_err_pix < 24);
    assert(abs(x2p' * F * x1p) < 0.2);
end

%% Visualize results
% Projected (note: allM(3,:) === 1):
close all
figure();
scatter(allM(1,:), allM(2,:));

figure();
scatter(allM2(1,:), allM2(2,:));

%disp('writing points.obj')
%dlmwrite('points.obj', allX', ' ')
%save('cow_stereo_points.mat','allX')
% Visualize 3D points (Question 4)
figure();
scatter3(allX(1,:), allX(2,:), allX(3,:),'.');
axis equal;
