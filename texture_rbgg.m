function texture = texture_rbgg()
    % simple 2x2 test texture, good for testing linear interpolation
    texture = [];
    texture(:,:,1) = [1 0;0 0];
    texture(:,:,2) = [0 0;1 1];
    texture(:,:,3) = [0 1;0 0];
    