% highlight removal via downscaling of gradients and poisson reconstruction

a = imread8toDouble('highlightremoval1.jpg'); % HighlightRemovalTarget.png highlightremoval1.jpg
g = forward_differences2_list_color(a);
mask = imread8toDoubleGrayscale('highlightremoval1_mask.png') > 0.5;  % for highlightremoval1
%mask = imread8toDoubleGrayscale('HighlightRemovalMask.png') < 0.5; % for HighlightRemovalTarget

figure(1)
imshow(rescale01(g(:,:,1,2)))

% compress within mask
for c=1:3
    for y=1:imageHeight(a)
        y
    for x=1:imageWidth(a)
        if mask(y,x)
            g(y,x,:,c) = fake_gamma_compression(g(y,x,:,c), 0.1);%0.5 * g(y,x,:,c);%fake_gamma_compression(g(y,x,:,c), sqrt(2)/2);
        end
    end
    end
end

figure(2)
imshow(rescale01(g(:,:,1,2)))

% reconstruct
sol = solve_poisson_equation2_color(a,g,mask);
figure(3)
imshow(sol)