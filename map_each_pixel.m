function nimage = map_each_pixel(f, image)
  % given a color or grayscale image, (or any h x w x c array)
  % apply f: c -> d at each pixel
  % you might have to apply x(:) in f(x) to get a column vector instead of
  % a [1 1 c] matrix
  % Maybe you also want to transpose.
  %
  
  hw = waitbar_start('map each pixel in progress...');
  nimage = [];
  for y=1:imageHeight(image)
    waitbar(y/imageHeight(image));
    for x=1:imageWidth(image)
      nimage(y,x,:) = f(image(y,x,:));
    end
  end
  close(hw);