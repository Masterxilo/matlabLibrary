function [depth] = depthFromNormals(n, mask)
  % [depth] = depthFromNormals(n, mask)
  %
  % Input:
  %    n is an [N, M, 3] matrix of surface normals (or zeros
  %      for no available normal).
  %    mask logical [N,M] matrix which is true for pixels
  %      at which the object is present.
  % Output
  %    depth an [N,M] matrix providing depths which are
  %          orthogonal to the normals n (in the least
  %          squares sense).
  %
  assert(islogical(mask));
  
  
  imsize = size(mask);
  %imsize = size(n(:,:,1))

  % Assume all normals are valid
%imagesc(n)

w = imsize(2);
h = imsize(1);
assert(size(n, 3) == 3);

% Center position
c = floor([h/2, w/2]);
cx = c(2);
cy = c(1);

% equation system
% w*h unknowns (z(x,y))
% h * (w-1) equations for points with right neighbors
% w * (h-1) for points with lower neighbors
% + 1 for the initial value at the image center
% Ax = b
eqs = h * (w-1) + w * (h-1) + 1;
A = sparse(eqs, w*h);
b = zeros(eqs, 1);

i = 1; % current equation

hw = waitbar_start('depthFromNormals equation setup...');
% 1. right neighbor equations
for y=1:h
    waitbar(y/h, hw);
    for x=1:w-1
        cn = n(y,x, :);
        
        % Locations of the relevant z(x,y) in the unknown array
        % it is column major
        xz = x-1; yz = y-1;
        l1 = yz + (xz)*h;
        l2 = yz + (xz + 1)*h;
        
        % Set factors (for equation: cn1 + cn3(z(x+1,y) - z(x,y)) == 0)
        A(i, l1+1) = -cn(3);
        A(i, l2+1) = cn(3);
        b(i) = -cn(1);
        
        i = i+1;
    end
end


% 2. lower neighbor equations
for y=1:h-1
    waitbar(y/(h-1), hw);
    for x=1:w
        cn = n(y,x, :);
        
        % Locations of the relevant z(x,y) in the unknown array
        % it is column major
        xz = x-1; yz = y-1;
        l1 = yz + (xz)*h;
        l2 = (yz+1) + (xz)*h;
        
        % Set factors (for equation: cn2 + cn3(z(x,y+1) - z(x,y)) == 0)
        A(i, l1+1) = -cn(3);
        A(i, l2+1) = cn(3);
        b(i) = -cn(2);
        
        i = i+1;
    end
end


close(hw);

% 3. constrain center value to be 1
l = (cy-1) + (cx-1)*h;

% Set factors (for equation: z(cx,cy)) == 1)
A(i, l+1) = 1;
b(i) = 1;
i = i+1;


% solve in least squares sense
disp('solving...');
x = lsqr(A, b);% pinv(full(A)) * b; % or A\b

% extract z from solution
depth = reshape(x, [h w]);
