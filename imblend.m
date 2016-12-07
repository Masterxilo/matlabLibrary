function o = imblend(image1, mask1, image2, mask2)
  % blends between image1 and image2 pointwise by giving !renormalized!
  % weights according to the masks
  
  assert_same_size(image1, image2);
  assert_same_size12(image1, mask1);
  assert_same_size12(image2, mask2);
  assert(size(mask1,3) == 1);
  assert(size(mask2,3) == 1);
  
  o = image1;
  for i=1:size(image1,3)
    o(:,:,i) = ( image1(:,:,i) .* mask1 + image2(:,:,i) .* mask2 )./ (mask1 + mask2); %division for normalization
  end