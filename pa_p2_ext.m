% Probabilistic algorithms problem set 2

h.CDataMapping = 'direct';
colormap([1 0 0;0 1 0;0 0 1])
image([1 1 2;3 2 1])

dim = 4;

g = 0.05;%0.025/4;%0.05;

o = dim/g;
img = ones(o);

for xi=1:o
	for yi=1:o
        % -dim/2 for centering in 0,0
		x = (xi-1)*g - dim/2;
		y = (yi-1)*g - dim/2;

		%[x;y]
		img(yi,xi) = newtonRaphsonP1([x;y]);
	end
end


image(img)