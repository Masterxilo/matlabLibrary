function out = imfillholes(image, filler)
  % uses filler whereever image is black
  assert_same_size(image, filler);
  mask_filler = sum(image, 3) == 0;
  out = immask_combine(image, filler, mask_filler);