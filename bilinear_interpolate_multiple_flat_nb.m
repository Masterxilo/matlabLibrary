function [colors] = bilinear_interpolate_multiple_flat_nb(flat_texture, dim, channels, points)
  % subfunction of bilinear_interpolate_multiple_flat, 
  % assuming no zeropad and out-of-bound points
  
  n = size(points,2);

  % nearest neighbor coordinates in all directions
  floor_points = floor(points);
  ceil_points = ceil(points);
  
  points00 = floor_points;
  points10 = [ceil_points(1,:);floor_points(2,:)];%[ceil(points(1,:));floor(points(2,:))];
  points01 = [floor_points(1,:);ceil_points(2,:)];%[floor(points(1,:));ceil(points(2,:))];
  points11 = ceil_points;

  uv = points - points00;

  % do lookups
  points00i = sub2ind(dim, points00(2,:), points00(1,:));
  points01i = sub2ind(dim, points01(2,:), points01(1,:));
  points10i = sub2ind(dim, points10(2,:), points10(1,:));
  points11i = sub2ind(dim, points11(2,:), points11(1,:));

  % texture fetches - this takes a long time (bad on cache...: random gather operation)
  % and we don't even fetch nearby pixels (which we will need) at the same
  % time
  t00 = flat_texture(:, points00i);
  t01 = flat_texture(:, points01i);
  t10 = flat_texture(:, points10i);
  t11 = flat_texture(:, points11i);
  
  assert_equal(size(t00), [channels n]);

  % weights are
  u = uv(1,:);
  v = uv(2,:);
  omu = (1-u);
  omv = (1-v);
  
  w00 = omu .* omv;%(1-u) .* (1-v);
  w10 = u .* omv;%u .* (1-v);
  w01 = omu .* v;%(1-u) .* v;
  w11 = u .* v;


  % extend weights to have same amount of rows as texture has channels
  % for later pointwise multiply
  w00 = repmat(w00,channels,1);
  w10 = repmat(w10,channels,1);
  w01 = repmat(w01,channels,1);
  w11 = repmat(w11,channels,1);
  
  % weight texture samples and add up
  colors = w00 .* t00 +  w10 .* t10 +  w01 .* t01 +  w11 .* t11;
  
  % not faster:
  %colors = w00 .* t00 +  w10 .* t10;
  %colors = colors + w01 .* t01;
  %colors = colors + w11 .* t11;
