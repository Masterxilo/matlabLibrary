function Lchrome = CV01_EstimateLightDirections()
  %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % PART 1:  Estimate Light Source Directions using chrome 
  %          sphere images.
  [mask, images] = CV01_readMaskAndColorImages('ps.chrome');
  nDir = size(images, 4);
  Lchrome = fitLightDirectionChromeSphereMultiple(images, mask, true);

  % Sanity checks
  if size(Lchrome) ~= [3 nDir]
    error('Error: Lchrome is not a 3xnDir matrix');
  end
  
  nrm = sqrt(sum(Lchrome.^2,1));
  if any(abs(nrm - 1) > 1.0e-6)
    error('Error: Lchrome are not unit vectors\n');
  end
  
  % Since we are looking down the z-axis, the direction
  % of the light source from the surface should have
  % a negative z-component, i.e., the light sources
  % are behind the camera.
  if any(find(Lchrome(3,:) >= 0))
    error('Error: Lchrome z are not all negative\n');
  end
  
  % Plot recovered directions' x and y components
  
  figure();
  % Circle
  theta = 0:0.1:2*pi;
  theta = [theta 2*pi];
  plot(cos(theta), sin(theta), 'k');
  
  % Points
  hold on;
  
  drawArrow = @(x,y) quiver( x(1),y(1),x(2)-x(1),y(2)-y(1),0 );
  
  %hLS(1) = 
  %plot(Lchrome(1,:), Lchrome(2,:), '*r');
  % Labels
  for k = 1:nDir
    drawArrow([0 0], [1 1]);%Lchrome(1,k), Lchrome(2,k)]);
    text(Lchrome(1,k), Lchrome(2,k), sprintf(' %d', k-1));
  end
  
  % Formatting
  axis ij; % axis equal;
  title('Orthographic image of light source directions.');
  xlabel('x'); ylabel('y');


  % END OF PART 1.