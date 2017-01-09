function r = array_data_range(x)
  % returns [1 size(x,1) 1 size(x,2) ...], suitable for axes range
  % (axis(limits)) or xyzlim
  
  r = [repmat(1,1,length(size(x)));size(x)];
  r = r(:)';