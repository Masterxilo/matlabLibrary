function [oninds] = selectRegionPoints(im, positions)
% takes as input an image to show, as well as some positions on it
% (e.g. where it has SIFT descriptors extracted).
%
% Displays the image, then lets a user select a polygonal region.
% Then it determines which of the given positions fall within that region,
% and returns a list of indices into positions telling which points are within the region.

% positions is n x 2
% onids is a list of indices into the rows of positions, namely those
%   within the polygon.

uiwait_msgbox('select a polygonal region including some points. Double click to close the polygon');
imshow(im);

h = impoly(gca, []);
api = iptgetapi(h);
nextpos = api.getPosition();

ptsin = inpolygon(positions(:,1), positions(:,2), nextpos(:,1), nextpos(:,2));
oninds = find(ptsin==1); % these are the indices into positions that fall within the polygon region
