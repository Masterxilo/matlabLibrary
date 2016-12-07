function out = imcutrect(image, mask)
  % Given an image and a mask of the same size, finds 
  % the largest rectangle of 1s in the mask and cuts out this part of
  % the image
  [x,y,w,h] = FindLargestRectangle(mask);
  for i=1:size(image,3)
    out(:,:,i) = image(y:y+h-1, x:x+w-1, i);
  end