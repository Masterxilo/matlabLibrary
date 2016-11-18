% test reconstructing color image without modifying gradients
% using solve_poisson_equation2_color

% conversion to double not strictly necessary
target=imread8toDouble('switzerland_target.png');
mask=imread8toDoubleGrayscale('switzerland_mask.png');

dim = min([size12(target);size12(mask)]);

target = target(1:dim(1), 1:dim(2), :);
mask = mask(1:dim(1), 1:dim(2));

% binarize mask
mask = mask < 0.5; % note: I want the black regions to be true, i.e. 'yes, please compute something here!'

%imshow(target)
%imshow(mask)

% Compute gradients
grad_target = forward_differences2_list_color(target);

if 0 % visualize
  for d=1:2
    for c=1:3
      subplot(2,3,sub2ind([2,3],d, c))
      imshow(rescale01(grad_target(:,:,d,c)))
    end
  end
  return
end

%imshow(rescale01(grad_target(:,:,2)))

% Set target to 0 where mask is 1, creating a hole

for i=1:3
  hole_target(:,:,i) = (1-mask) .* target(:,:,i);
end

imshow(hole_target)
%return
% Ready to call grayscale version of solve_poisson_equation
output = solve_poisson_equation2_color(hole_target, grad_target, mask);
% output should look like target (without the hole)
imshow(output)