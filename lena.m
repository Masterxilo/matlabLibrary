function i = lena()
  % returns the lena image as an [h w 3] array of doubles in [0, 1]
  i = imread8toDouble('lena.jpg');