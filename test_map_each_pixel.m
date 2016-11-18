i = imread8toDouble('image2.png');

imshow(map_each_pixel(@(x) [0 x(2) 0], i))

imshow(map_each_pixel(@(x) x(3), i))