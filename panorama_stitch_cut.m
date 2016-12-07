function out = panorama_stitch_cut(image1, image2)
  % same as panorama_stitch but uses imcutrect on the resulting mask
  % to extract the largest rectangle of pure image data
  [image, mask] = panorama_stitch(image1, image2);
  out = imcutrect(image, mask);