close all
w = 32;
h = 39;
points = [1 -1;1 1] * coordinates_list_2n([1,w], [1,h]) + repmat([40;0] + 0.2,1,w*h); % + 0.2 because we can
figure();

image = imdownsample(imdownsample(lena()));
imshow(image);
hold on
scatter(points(1,:), points(2,:));

colors = bilinear_interpolate_multiple(image, points);
size(colors)
imshow_in_figure(reshape(shiftdim(colors,1), h,w,3), 'sampled points')