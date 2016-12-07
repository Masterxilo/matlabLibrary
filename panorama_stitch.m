function [final_image, image_mask] = panorama_stitch(image1, image2, homography_estimator) 
  % panorama-stiches two images through sift descriptor matching,
  % homography transform and blending
  %
  % homography_estimator can be homography2d_ransac(2)
  if nargin < 3
    homography_estimator = @homography2d_ransac;
  end
  
  best_h = panorama_stitch_homography(image1, image2, homography_estimator);
  
  [target_data_range, target_size] = panorama_stitch_get_boundaries(image1, image2, best_h);
  
  mask = boundary_distance_mask_manhattan2(size12(image1));
  
  source_data_range = [1 imageWidth(image1) 1 imageHeight(image1)];
  
  i1 = imtransform_bilinear_homography(image1, inv(best_h), source_data_range, target_data_range, target_size);
  i2 = imtransform_bilinear_homography(image2, eye(3), source_data_range, target_data_range, target_size);
  i1m = imtransform_bilinear_homography(mask, inv(best_h), source_data_range, target_data_range, target_size);
  i2m = imtransform_bilinear_homography(mask, eye(3), source_data_range, target_data_range, target_size);
  
  final_image = imblend(i1,i1m,i2, i2m);
  image_mask = i1m + i2m > 0;
  