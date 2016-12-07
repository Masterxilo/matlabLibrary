function points = ginput2(n)
  % similar to ginput, but displays each point right after selection and
  % returns the points in a n x 2 matrix
  
  uiwait_msgbox(['please select ' num2str(n) ' points on the current figure']);
  
  hold on;
  points = [];
  for i=1:n
    [x,y] = ginput(1);
    assert(length(x) == 1);
    points = [points;x y];
    scatter(x,y, 'r');
  end
  
  assert(size(points,1) == n);
  assert(size(points,2) == 2);
  