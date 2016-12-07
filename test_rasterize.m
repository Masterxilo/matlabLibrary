% demonstrates missing pixels with rasterize
output_size = [81 100];
vertices = [ 
    30 80
    10  20
    100 50
    100 10];
triangles = [1 2 3;3 2 4]; % 3 2 4 because we need clockwise (...) ordering for rasterize! (assertion error will be thrown if not)

c = coordinates_list_2n([1 output_size(2)], [1 output_size(1)]);

m = rasterize(vertices(triangles(1,:),:)', c);
m = reshape(m,output_size(1), output_size(2));

m2 = rasterize(vertices(triangles(2,:),:)', c);
m2 = reshape(m2,output_size(1), output_size(2));

close all
figure()
imshow(m + m2)
hold on
triplot(triangles, vertices(:,1), vertices(:,2))