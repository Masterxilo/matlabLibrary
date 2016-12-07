function sampledDescriptors = CV03_sampleDescriptors(sifts)
  n = length(sifts);
  
  % Sample DESCS descriptors from IMS images
  sampledDescriptors = [];
  IMS = 100;
  DESCS = 1000;
  
  hw = waitbar_start('sampling descriptors');
  for i=1:IMS
      waitbar(i/IMS, hw);
      % From image j:
      j = randi(n);

      descriptors = sifts(j); % gives a structure array
      descriptors = descriptors.descriptors;

      %assert(size(descriptors,1) >= DESCS); % need many descriptors
      % Use 1000 randomly selected descriptors
      m = randperm(size(descriptors,1));
      if length(m) >  DESCS
        m = m(1:DESCS);
      end
      sampledDescriptors = [sampledDescriptors;descriptors(m,:)];
  end

  close(hw);
  
  assert(~isempty(sampledDescriptors));
assert(size(sampledDescriptors,1) <= IMS*DESCS);
assert(size(sampledDescriptors,2) == 128);