%      *0*:s
%  / (-3)   \ (-2)   <- first row of UNARY
% [1] -(1)- [2]
%  \ (-1)   / (-4)   <- second row of UNARY
%      *1*:t

% min-cut:
%      *0*:s
%           \ (-2)   <- first row of UNARY
% [1]       [2]
%  \ (-1)            <- second row of UNARY
%      *1*:t
% with cost (ENERGYAFTER) -6.

[LABELS, ENERGYAFTER] = graph_minstcut([-3 -2;-1 -4],[0 1;1 0]);
assert(all(labels == [1 0]'));
assert(-6 == ENERGYAFTER);