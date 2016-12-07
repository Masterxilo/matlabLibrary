  function [colorImages] = imreaddouble_multiple_numbered0(basepath, ext)
  % reads color images into a matrix of shape 
  %   height x width x 3 x n
  % named <basepath>.0.png to <basepath>.<n-1>.<ext>
  % where n is discovered automatically by checking whether the file exists
  % basepath is e.g. '../images/buddha/buddha' or 'ps.cat.'
  % ext defaults to png
  
  if nargin < 2
    ext = 'png';
  end
  
  i = 0;
  while true
    try
      colorImages(:,:,:,i+1) = imreaddouble([basepath '.' num2str(i) '.' ext]);
      assert(size(colorImages,3) == 3);
      i = i + 1;
    catch E
      break;
    end
  end