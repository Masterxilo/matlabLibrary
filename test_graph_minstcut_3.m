%      *0*:s
%  / (-1)   \ (-2)   <- first row of UNARY
% [1] -(1)- [2]
%  \ (-1)   / (-3)   <- second row of UNARY
%      *1*:t

% min-cut:
%      *0*:s
%  / (-1)   \ (-2)  
% [1] -(1)- [2]

%      *1*:t
% with cost -4.

labels = graph_minstcut([-1 -2;-1 -3],[0 1;1 0]);
assert(all(labels == [0 0]'));