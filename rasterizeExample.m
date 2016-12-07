% Example for the "Rasterize" function.
% Assume we have the trianlge
v1 = [ 0; 0]; 
v2 = [100; 50];
v3 = [ 30; 80];
% Get them togheter in one 2x3-matrix
v = [v1 v2 v3];

% Now, let's ask our "rasterize function" which pixels are in the
% triangles, which are outside.
out = rasterize(v, coordinates_list_2n([1 100],[1 100]));

% reshape output, such that we get back our image
out = reshape(out, size(X));

% Display output and triangle
imshow( out )
hold on;
plot([v(1,:) v1(1)], [v(2,:) v1(2)], 'r')
hold off;