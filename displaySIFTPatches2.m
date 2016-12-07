function displaySIFTPatches2(f)
  % converts raw f from vl_sift to the format required for displaySIFTPatches
  % and calls it  
  positions = f(1:2,:)';
  scales = f(3,:)';
  orients = f(4,:)';
  
  displaySIFTPatches(positions, scales, orients);