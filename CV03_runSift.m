function o = CV03_runSift(I)
  % runs sift feature detection on 
  % the image I, returning a struct with entries
  % descriptors, positions, scales, orients
  %
  % note that there may be no features detected
  
  vl_setup2();
  
  % compute sift on grayscale
  [f, d] = vl_sift(single(rgb2gray(I)));
      %'PeakThresh', PeakThresh ... % don't grab too many features

  % Extract data as requested by format
  numfeats = size(f, 2);
  assert(numfeats == 0 || size(f,1) == 4);
  assert(numfeats == 0 || (size(d,1) == 128 && size(d,2) == numfeats));

  o = struct();
  o.descriptors = double(d'); % uint8 descriptors returned by default
  o.positions = f(1:2,:)';
  o.scales = f(3,:)';
  o.orients = f(4,:)';