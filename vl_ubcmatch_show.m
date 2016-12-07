function vl_ubcmatch_show(image1, f1, image2, f2, matches)
  % see match_show_vert for a more general corresponding point visualization
  
  assert_same_size(image1, image2);
  
  image = image1();
  
  w = imageWidth(image1);
  
  image(:,w+1:2*w,:) = image2;
  
  imshow(image);
  f2(1,:) = f2(1,:) + w;
  
  vl_plotframe_yk(f1(:,matches(1,:)));
  vl_plotframe_yk(f2(:,matches(1,:)));
  
  for mab = matches
    p1 = f1(1:2, mab(1));
    p2 = f2(1:2, mab(2));
    line([p1(1) p2(1)], [p1(2) p2(2)]);
  end
  