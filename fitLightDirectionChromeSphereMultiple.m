function [L] = fitLightDirectionChromeSphereMultiple(colorImages, mask, chatty)
  % Input:
  %  colorImages -- sequence of images, each showing a highlight reflected on a sphere, from which we can derive the incoming light direction
  %     height x width x channels x nDir array
  %  mask -- corresponding mask of the sphere, logical
  %  chatty -- [false] true to show results images. 
  % Return:
  %  L is a 3 x nDir image of light source directions.

  % Since we are looking down the z-axis, the direction
  % of the light source from the surface should have
  % a negative z-component, i.e., the light sources
  % are behind the camera.
  
  [~,width,channels,nDir] = size(colorImages);
  assert(channels == 3 || channels == 1);
  assert(isreal(colorImages));
  assert(isdouble(colorImages));
  assert(islogical(mask));
  
  if ~exist('chatty', 'var')
    chatty = false;
  end
  
  % Silence imfindcircles warning:
  ss = warning;
  warning off;
  
  % Detect sphere center and radius from mask
  [centerSphere, radiusSphere] = imfindcircles(mask,[10 width]); % fails sometimes?
  assert(length(centerSphere) == 2);
  assert(length(radiusSphere) == 1);
  
  if chatty
    figure();
    colormap 'gray';
    image(mask*255);
    viscircles(centerSphere, radiusSphere,'EdgeColor','b');
  end
  
  L = [];
  % for each light
  for n=1:nDir
    imData = colorImages(:,:,1,n) .* mask; % keep only red channel, mask out
    
    % Find the highlight's 2d xy
    % Find bright spots
    [centerHighlight, radiusHighlight] = imfindcircles(imData,[5 round(width*0.2)],'ObjectPolarity','bright');
    if ~all(size(centerHighlight) == [1 2])
        warning on;
        warning('Error: found too few/many highlights in image %s, skipping.\n', fname);
        warning off;
        continue;
    end
    
    if chatty
        figure();
        imshow(imData);
        viscircles(centerHighlight, radiusHighlight,'EdgeColor','b');
    end
    
    % do the math:
    % Assume the sphere has unit size
    vxy = centerHighlight - centerSphere;
    vxy = vxy / radiusSphere;
    % vxy is the projection onto xy of the unit vector from the center of
    % the sphere pointing towards the bright spot.

    % construct unit normal
    % There are two possible z to extends vxy into a unit vector:
    % +- sqrt(1-norm(vxy)^2)
    % use the more negative one (pointing to camera)
    n = [vxy';-sqrt(1-norm(vxy)^2)];

    % Reflect to-camera direction on this vector
    toCamera = [0;0;-1];

    % cL = reflect toCamera on n
    cL = 2*n*dot(toCamera,n) - toCamera;
    % This is the direction towards the lightsource (the lightsource
    % appears on the chrome sphere where the exact direction towards the light
    % reflects directly into the camera).

    % Append light direction
    L = [L cL];
  end

  % Re-enable warnings
  warning(ss);
