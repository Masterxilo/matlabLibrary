% the order is important given tha mask (colors might be weird if swapped)
a = imread8toDouble('gradientmixC2.png'); % gradientmixC2 gradientmix1 gradientmixB1
b = imread8toDouble('gradientmixC1.png'); % gradientmixC1 gradientmix2 gradientmixB2

ag = forward_differences2_list_color(a);
bg = forward_differences2_list_color(b);

% for gradientmix1|gradientmix2 pair
%mask = imread8toDoubleGrayscale('gradientmix_mask.png') > 0.5;
% everything but the boundary
mask = zeros(size(a,1),size(a,2)); mask(2:end-1, 2:end-1) = 1; mask = mask == 1;

g = [];
if 0
    % component-wise
    for d=1:2
    for c=1:3
      b_larger_mask = abs(bg(:,:,d,c)) > abs(ag(:,:,d,c)); % mask which is true when b is larger in magnitude

      g(:,:,d,c) = immask_combine(ag(:,:,d,c),bg(:,:,d,c),b_larger_mask); % this is not the same: max(ag(:,:,d,c), bg(:,:,d,c));
    end
    end
else
    % using norm -- similar result
    for c=1:3
        
        b_larger_mask = bg(:,:,1,c).^2 + bg(:,:,2,c).^2 > ag(:,:,1,c).^2 + ag(:,:,2,c).^2; % mask which is true when b is larger in magnitude
    
    for d=1:2
        
      g(:,:,d,c) = immask_combine(ag(:,:,d,c),bg(:,:,d,c),b_larger_mask); % this is not the same: max(ag(:,:,d,c), bg(:,:,d,c));
    end
    end
end

sol = solve_poisson_equation2_color(a, g, mask);
%sol = solve_poisson_equation_color(a, g, mask,100); % this takes much too long

imshow(sol)