close all
fig = imshow_in_figure(lena(), 'select points of interest on lena');

pointsn2 = getpts2(fig);

hold on
scatter2(pointsn2');
title('selected points:')