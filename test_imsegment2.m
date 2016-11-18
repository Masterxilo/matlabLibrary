% trivial image with enough pixels to estimate color model
% sanity check
red = [1 0 0];
green = [0 1 0];

k = 10; % enough pixels to estimate color model
image = zeros(1,2*k,3);
regionA = zeros(1,2*k);
regionB = zeros(1,2*k);

for i=1:k
image(1,i,:) = red * (1-0.2*rand()) + 0.2*[0 rand() rand()]; % must have some variation to estimate color model
regionA(1,i) = 1;
end
regionA(1,k) = 0; % reset one assignment: region will have to grow by this

for i=k+1:2*k
image(1,i,:) = green * (1-0.2*rand()) + 0.2*[rand() 0 rand()];
regionB(1,i) = 1;
end
regionB(1,k+1) = 0; % reset one assignment: region will have to grow by this

figure(1)
imshow(image);

regionA
regionB

labels = imsegment2(image, regionA  == 1, regionB  == 1, 1)
figure(4)
imshow(labels)

expected_labels = [repmat(0,1,k) repmat(1,1,k)];

assert_equal(labels, expected_labels);