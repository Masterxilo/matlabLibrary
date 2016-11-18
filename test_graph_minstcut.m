% *0*:s
%  | (-1)   <- first row of UNARY
% [1]
%  | (-2)   <- second row of UNARY
% *1*:t

% min-cut:
% *0*:s
%  |
% [0]
%
% *1*
% with cost -2.

labels = graph_minstcut([-1;-2],[0]);
assert(length(labels) == 1);
assert(all(labels == 0));