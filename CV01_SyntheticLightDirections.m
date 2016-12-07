function Lsyn = CV01_SyntheticLightDirections()
  % some interesting light directions in the same format as created by fitLightDirectionChromeSphereMultiple
  % 3 x nDir
  
  t = 0:0.15:2*pi;
  r = 0.5;
  Lsyn = zeros(3, length(t));
  Lsyn(1,:) = r * cos(t);
  Lsyn(2,:) = r *sin(t); % note that this will go around clockwise, starting on the right, because y points down
  Lsyn(3,:) = -sqrt(1 - sum(Lsyn(1:2,:).^2,1));