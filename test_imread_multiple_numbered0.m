close all
i = imread_multiple_numbered0('ps.cat');
n = size(i,4);

for j=1:n
  imshow_in_figure(i(:,:,:,j), num2str(j));
end