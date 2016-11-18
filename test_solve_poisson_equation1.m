% test reconstructing image without modifying gradients

% conversion to doulbe not strictly necessary
target=imread8toDoubleGrayscale('switzerland_target.png');
mask=imread8toDoubleGrayscale('switzerland_mask.png');

dim = min([size12(target);size12(mask)]);

target = target(1:dim(1), 1:dim(2));
mask = mask(1:dim(1), 1:dim(2));

% binarize mask
mask = mask < 0.5; % note: I want the black regions to be true, i.e. 'yes, please compute something here!'

close all
figure(2)
imshow(target)
%imshow(mask)


% Compute gradients
grad_target = forward_differences2_list(target);

%imshow(rescale01(grad_target(:,:,1)))
%imshow(rescale01(grad_target(:,:,2)))

% Set target to 0 where mask is 1, creating a hole
hole_target = (1-mask) .* target;

%imshow(hole_target)

% Ready to call grayscale version of solve_poisson_equation
figure(1)
output = solve_poisson_equation(hole_target, grad_target, mask, 1000); % even after 1000 iterations its still quite dark
% output should look like target (without the hole)
%imshow(output)