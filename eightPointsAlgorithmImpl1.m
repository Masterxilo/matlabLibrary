function [F] = eightPointsAlgorithmImpl1(x1,x2, normalized)

assert(size(x1,1) == 3);
assert(size(x2,1) == 3);
% TODO assert that x*(3,:) is 1, ..., 1 approximately

N = size(x1,2);
assert(N >= 8);
assert(size(x2,2) == N);

if nargin < 3
    normalized = true;
end
    
if normalized
    % [ Set up normalization (normalization is not strictly necessary, but
    % improves numerical stability)
    % Origin = centroid
    % T1 normalizes x1 data
    % T2 normalizes x2 data
    T1 = eightPointsAlgorithm_getNormalizer(x1);
    T2 = eightPointsAlgorithm_getNormalizer(x2);
    % ]
else
    % Just using the following instead of computing the normalizers above also works somewhat 
    % (no normalization --> instable for lots of points):
    T1 = eye(3);
    T2 = eye(3);
end


% Set up equation system as on slides (except last column, see below):
% Note that we might have much more than 8 lines - in that case we will
% solve the system in the least-squares sense.
A = zeros(N,8);
for i=1:N
    % x_1 = [u;v;1]
    % x_2 = [u';v';1]
    x_1 = T1 * x1(:,i);
    x_2 = T2 * x2(:,i);
    
    muuvv = x_1 * x_2';
    uuvv = reshape(muuvv,1,9);
    
    assert(x_2(1) == uuvv(3)); % u'
    assert(uuvv(3) == muuvv(3,1));
    A(i, :) = uuvv(1:8);
end

% Fix f33 = 1, move to right hand side --> right hand side becomes -1 ... -1
b = repmat(-1, N,1);

% Solve
F = A\b; % don't use lsqr, much less precise
assert(length(F) == 8);

% append f33 == 1
F(9) = 1; % or F(end + 1) = 1 or F = [F;1]
F = reshape(F, 3,3)'; % ': compare slides, we assumed F is F(1,1) then F(1,2) etc.
% but linear memory layout in matlab is column wise!


% [ Undo normalization
F = T2' * F * T1; 
% ]


% Enforce the rank-2 constraint
[U, S, V] = svd(F);
S(3) = 0;
F = U * S * V';

% Renormalize to last component == 1
F = F/F(9);


% [ Optional Test: Check fundamental matrix defining property:
% x2 . F . x1 == 0
% for each pair of corresponding points x1, x2
for i=1:N
    zer = abs(x2(:,i)' * F * x1(:,i));
    %assert(abs(zer) < 0.001); % TODO what tolerance?
end
% ]


return;


