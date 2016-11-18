image = imread8toDouble('ForegroundBackgroundImage.png');
mask = imread8toDoubleGrayscale('ForegroundBackgroundImageForegroundMask.png') > 0.5;
r = immaskcolors(image, mask);
assert(size(r,1) == 3);
assert(size(r,2) == total(mask));
i = [];
i(1,:,:) = r';

i = i(1,1:100,:);
imshow(i);


% again
mask = imread8toDoubleGrayscale('ForegroundBackgroundImageBackgroundMask.png') > 0.5;
r = immaskcolors(image, mask);
assert(size(r,1) == 3);
assert(size(r,2) == total(mask));
i = [];
i(1,:,:) = r';

i = i(1,1:100,:);
imshow(i);

return;