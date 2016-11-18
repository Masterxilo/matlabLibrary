target=imread8toDouble('seamless_background1.jpg'); % seamless_background1 seamless_background1_Downsampled
source=imread8toDouble('seamless_foreground1.jpg'); % seamless_foreground1 seamless_foreground1_Downsampled
mask=imread8toDoubleGrayscale('seamless_mask1.jpg') > 0.5; % seamless_mask1 seamless_mask1_Downsampled

% Compute gradients
grad_target = forward_differences2_list_color(target);
grad_source = forward_differences2_list_color(source);
rmask = most(mask);
gradients = grad_target;
for i=1:3 % each channel
for j = 1:2 % each partial derivative
gradients(:,:,j,i) = immask_combine(grad_target(:,:,j,i), grad_source(:,:,j,i), rmask); % Use grad_source where mask is 1
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
cp(:,:,i) = immask_combine(target(:,:,i), source(:,:,i), mask);
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