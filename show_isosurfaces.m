function show_isosurfaces(data, titl)
  % simple isosurface visualization
  % showing 3 slices at 0.1, 0.5 and 0.9 lerp between min and max value
  % Similar to ListContourPlot3D[]
  if nargin == 1
    titl = '';
  end
  
  assert(length(size(data)) == 3);
  assert(isreal(data));
[mi, ma] = min_and_max2(data);
mm = mean(min_and_max(data));

figure('Name',titl);
ax = axes();
hold on
lims = array_data_range(data);

h = patch(isosurface(data, lerp(mi, ma, 0.1)));
set(h,'FaceColor','none') ;
set(h,'EdgeColor','red') ;

assert(lerp(mi, ma, 0.5) == mm);
h = patch(isosurface(data, lerp(mi, ma, 0.5))); % == mm
set(h,'FaceColor','none') ;
set(h,'EdgeColor','green') ;


h = patch(isosurface(data, lerp(mi, ma, 0.9)));
set(h,'FaceColor','none') ;
set(h,'EdgeColor','blue') ;


% note : flipped labels because of how images/plots are displayed
xlabel(ax, 'y') 
ylabel(ax, 'x') 

zlabel(ax, 'z') 

axis equal

xyzlim(lims);
title(titl);