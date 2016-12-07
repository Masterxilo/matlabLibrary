function s = toMathematica(o)
  % tries to give a string-representation of o that is interpretable in
  % Mathematica as roughly the same kind of object
  %
  % does not insert any more spacing than necessary
  %
  % specifically: structs become associations
  % matrices become arrays (in the mathematica ordering, such that in
  % m(a,b,c), varying the index c goes through the data
  %
  % This tries to generate results that reproduce the doubles bit-by-bit.
  % We cannot carry extra information with NaNs (in fact, they are not
  % supported for now). The output is quite long because it always uses 17
  % digits (if we give more, Mathematica will not use machine doubles)
  
  if ischar(o) && isrow(o)
      s = ['"' o '"'];
    
  elseif isstruct(o)
    
    s = '<|';
    fns = fieldnames(o);
    for k= 1:length(fns)
      fn = fns{k};
      s = [s toMathematica(char(fn)) '->' toMathematica(getfield(o, char(fn)))];   
      
      if k ~= length(fns)
        s = [s ','];
      end
      
    end
    s = [s '|>'];
      
  elseif isscalar(o)
    assert(isfinite(o));
    
    s = strrep(num2str(o, '%#.17g'), 'e', '*^'); % cannot use scientific format directly
    
  elseif isrow(o)
    
    s = '{';
    
    for j=1:length(o)
      s = [s toMathematica(o(j))];
      if j ~= length(o)
        s = [s ','];
      end
    end
    
    s = [s '}'];
    
  elseif ismatrix(o)
    s = '{';
    
    for j=1:size(o,1)
      s = [s toMathematica(o(j,:))];%  use shiftdim for higher-dimensional cases - TODO
      
      if j ~= size(o,1)
        s = [s ','];
      end
      
    end
    
    s = [s '}'];
  else
    error(['toMathematica unsupported expression of class ' class(o)]);
  end
  
  assert(ischar(s) && isrow(s));
  