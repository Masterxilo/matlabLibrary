target=imread8toDouble('switzerland_target.png');
source=imread8toDouble('switzerland_source.png');
mask=imread8toDoubleGrayscale('switzerland_mask.png');
dim = min([size12(target);size12(source);size12(mask)]);
target = target(1:dim(1), 1:dim(2),:);
source = source(1:dim(1), 1:dim(2),:);
mask = mask(1:dim(1), 1:dim(2));
mask = mask < 0.5; 
% Compute gradients
grad_target = forward_differences2_list_color(target);
grad_source = forward_differences2_list_color(source);
rmask = most(mask);
gradients = grad_target;
for i=1:3 % each channel
for j = 1:2 % each partial derivative
gradients(:,:,j,i) = (1-rmask) .* grad_target(:,:,j,i) + rmask .* grad_source(:,:,j,i); % Use grad_source where mask is 1
end
end


%imshow(rescale01(grad_target(:,:,1,c))) % c=1:3
%imshow(rescale01(grad_target(:,:,2,c)))
%imshow(rescale01(grad_source(:,:,1,c)))
%imshow(rescale01(grad_source(:,:,2,c)))
%imshow(target)
%imshow(source)
%imshow(mask)
%imshow(rescale01(gradients(:,:,1)))
%imshow(rescale01(gradients(:,:,2)))

% Ready to call solve_poisson_equation_color
figure(3)
for i=1:3
cp(:,:,i) = (1-mask) .* target(:,:,i) + mask .* source(:,:,i);
end
imshow(cp)
title('crude cut and paste')

figure(2)
imshow(target)
title('before gradient reconstruction')

figure(1)
output = solve_poisson_equation2_color(target, gradients, mask);
imshow(output)
title('after gradient reconstruction')