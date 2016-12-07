function [image1, image2] = CV02_bscp_images3()
  % gives images as expected by CV02_bscp_points3
  image1 = imreaddouble('bs.left.cp.jpg'); image2 = imreaddouble('bs.right.cp.jpg');

  maxSize = 500;
  % We assume images have the same size
  [M N ~] = size(image1);
  ratio = max(M,N)/maxSize;
  image1 = imresize(image1,1/ratio);
  image2 = imresize(image2,1/ratio);

