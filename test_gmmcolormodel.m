image = imread8toDouble('ForegroundBackgroundImage.png');
mask = imread8toDoubleGrayscale('ForegroundBackgroundImageBackgroundMask.png') > 0.5; % ForegroundBackgroundImageBackgroundMask ForegroundBackgroundImageForegroundMask
colors = immaskcolors(image, mask);

dist = gmmcolormodel(colors, 3);

show_colors(dist.mu', 'Gmm colormodel means');

p = @(x) pdf(dist, x(:)'); %  Note that we need a row vector.

if 0
for color=dist.mu'
    color
    p(color)
end
end

imshow_in_figure(rescale01(map_each_pixel(p, image)), 'probability at each pixel');
