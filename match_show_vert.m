function match_show_vert(image1, p1, image2, p2)
  % displays image1 on top of image2
  % drawing connections between each point in p1 and the point at the same
  % location in list p2, which have to be of the same size.
  
  assert_same_size(image1, image2);
  assert_same_size(p1, p2);
  assert(size(p1, 1) == 2);
  
  image = image1();
  
  h = imageHeight(image1);
  
  image(h+1:2*h,:,:) = image2;
  
  imshow(image);
  p2(2,:) = p2(2,:) + h;
  hold on
  scatter2(p1);
  scatter2(p2);
  
  for i = 1:size(p1,2)
    p1c = p1(:,i);
    p2c = p2(:,i);
    line([p1c(1) p2c(1)], [p1c(2) p2c(2)]);
  end