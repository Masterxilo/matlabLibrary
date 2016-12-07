function o = CV03_runSiftOnImages(images)
  % returns an array of structs, each the result of 
  % CV03_runSift
  % 
  % images(i) with i starting at 1 is either a 3-channel image or []
  
  i = 1;
  image = images(i);
  
  disp('runSiftOnImages...');
  while length(image) > 0
    disp(i);
    
    o(i) = CV03_runSift(image);
    i = i + 1;
    image = images(i);
  end