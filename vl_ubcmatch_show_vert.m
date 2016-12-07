function vl_ubcmatch_show_vert(image1, f1, image2, f2, matches)
  % visualizes the result of vl_ubcmatch by displaying the two images
  % one beneath the other and connecting corresponding points using lines
  %
  % see match_show_vert for a more general corresponding point visualization
  %
  % vl_ubcmatch_show does the same horizontally

  assert_same_size(image1, image2);
  
  image = image1();
  
  h = imageHeight(image1);
  
  image(h+1:2*h,:,:) = image2;
  
  imshow(image);
  f2(2,:) = f2(2,:) + h;
  
  vl_plotframe_yk(f1(:,matches(1,:)));
  vl_plotframe_yk(f2(:,matches(2,:)));
  
  for mab = matches
    p1 = f1(1:2, mab(1));
    p2 = f2(1:2, mab(2));
    line([p1(1) p2(1)], [p1(2) p2(2)]);
  end
  