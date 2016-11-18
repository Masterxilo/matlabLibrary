% test reconstructing image without modifying gradients
% same as test_solve_poisson_equation1 but calls solve_poisson_equation2 

% conversion to doulbe not strictly necessary
target=imread8toDoubleGrayscale('switzerland_target.png');
mask=imread8toDoubleGrayscale('switzerland_mask.png');
dim = min([size12(target);size12(mask)]);
target = target(1:dim(1), 1:dim(2));
mask = mask(1:dim(1), 1:dim(2));
mask = mask < 0.5;
grad_target = forward_differences2_list(target);

hole_target = (1-mask) .* target;

close all
figure(2)
imshow(target)
%imshow(mask)
%imshow(rescale01(grad_target(:,:,1)))
%imshow(rescale01(grad_target(:,:,2)))
%imshow(hole_target)

% Ready to call grayscale version of solve_poisson_equation
figure(1)
output = solve_poisson_equation2(hole_target, grad_target, mask);
% output should look like target (without the hole)
figure(1)
imshow(output)