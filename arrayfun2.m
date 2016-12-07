function r = arrayfun2(f, varargin)
  % like arrayfun, but assumes f generates outputs that are matrices
  % (of always the same size)
  r = cell2mat(arrayfun(f, varargin{:}, 'UniformOutput', false));