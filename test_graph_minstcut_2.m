% *0*:s
%  | (-2)   <- first row of UNARY
% [1]
%  | (-1)   <- second row of UNARY
% *1*:t

% min-cut:
% *0*:s
%  
% [0]
%  |
% *1*
% with cost -2.

labels = graph_minstcut([-2;-1],[0]);
assert(length(labels) == 1);
assert(all(labels == 1));