% Color balancing demo
% Demonstrates a few approaches the white balancing treated in the
% Computational Photography course.

img=double(imread('interior.jpg'))/255.;
imshow_in_figure('interior.jpg', 'interior.jpg')


averageRGB=mean(mean(img));

% Adjust such that each average is 0.3
for i=1:3
    adjustedTo03(:,:,i) = img(:,:,i) .* (0.3/averageRGB(i));
end

imshow_in_figure(adjustedTo03, 'Color balance interior.jpg to 0.3 average on all channels')

% Adjust such that the factor of channel j is 1.0
adjusted1 = img;
j = 2;
for i=1:3
    if i ~= j
        adjusted1(:,:,i) = img(:,:,i) .* (averageRGB(j)/averageRGB(i));
    end
end

imshow_in_figure(adjusted1, 'Color balance interior.jpg with factor 1.0 on green')

% adjust such that pixel at x,y = 265, 553 (on the book) is 0.95
target = img(553,265,:);

for i=1:3
    adjustedManual(:,:,i) = img(:,:,i) .* (0.95/target(i));
end

imshow_in_figure(adjustedManual, 'Color balance interior.jpg manually: make the book white')
