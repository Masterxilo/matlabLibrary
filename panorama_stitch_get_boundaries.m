function [target_data_range, target_size] = panorama_stitch_get_boundaries(i1, i2, best_h)
  % c.f. 
  assert_same_size(i1, i2);
  
  p1 = image_vertices(i1);
  p1t = homography_transform(best_h, p1);
  pa = [p1 p1t];

  aabbi = bounding_box_int_overestimate_dn(pa); % [aa bb]
  o__wh = bounding_box_dn_to_rectangle(aabbi); % [x y w h]

  target_data_range = reshape(aabbi', 1, 4) % target coordinate bounds [xmin xmax ymin ymax]
  target_size = o__wh([4 3]);