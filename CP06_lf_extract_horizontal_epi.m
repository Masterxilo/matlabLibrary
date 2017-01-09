function epi = CP06_lf_extract_horizontal_epi(lf, y)
  % given LFToolbox .LF, extract one horizontal line
  % through all centeral horizontal camera positions (there are not many)
  %
  % epi is 15 x image-width x 3, double
  
  epi = zeros(size(lf,2), size(lf,4), 3);
  for h=1:size(lf,2)
    epi(h,:,:) = uint16toUnorm(squeeze(lf(8,h,y, :, 1:3)));
  end
  
  