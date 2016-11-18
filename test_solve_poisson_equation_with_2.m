% test with a grayscale image
% same as test_solve_poisson_equation, but uses solve_poisson_equation2

% conversion to doulbe not strictly necessary
target=imread8toDoubleGrayscale('switzerland_target.png');
source=imread8toDoubleGrayscale('switzerland_source.png');
mask=imread8toDoubleGrayscale('switzerland_mask.png');

dim = min([size12(target);size12(source);size12(mask)]);

target = target(1:dim(1), 1:dim(2));
source = source(1:dim(1), 1:dim(2));
mask = mask(1:dim(1), 1:dim(2));

% binarize mask
mask = mask < 0.5; % note: I want the black regions to be true, i.e. 'yes, please compute something here!'

%imshow(target)
%imshow(source)
%imshow(mask)


% Compute gradients
grad_target = forward_differences2_list(target);
grad_source = forward_differences2_list(source);

%imshow(rescale01(grad_target(:,:,1)))
%imshow(rescale01(grad_target(:,:,2)))
%imshow(rescale01(grad_source(:,:,1)))
%imshow(rescale01(grad_source(:,:,2)))

% Use grad_source where mask is 1
rmask = most(mask);

gradients = grad_target;

gradients(:,:,1) = (1-rmask) .* grad_target(:,:,1) + rmask .* grad_source(:,:,1);
gradients(:,:,2) = (1-rmask) .* grad_target(:,:,2) + rmask .* grad_source(:,:,2);

%imshow(rescale01(gradients(:,:,1)))
%imshow(rescale01(gradients(:,:,2)))

% Ready to call grayscale version of solve_poisson_equation
figure(3)
imshow((1-mask) .* target + mask .* source)
title('crude cut and paste')

figure(2)
imshow(target)
title('before gradient reconstruction')

figure(1)
output = solve_poisson_equation2(target, gradients, mask);
imshow(output)
title('after gradient reconstruction')