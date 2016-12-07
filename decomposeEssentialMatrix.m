function [t,R] = decomposeEssentialMatrix(E) 
    % Decompose the Essential Matrix of epipolar/
    % pinhole stereo geometry into a possible rotation and 
    % translation component.
    %
    % Following the ansatz from Wikipedia,
    % Adjusted to notation in lecture: 
    % E := [t]_x * R, not R * [t]_x as on Wikipedia
    
    [U, S, V] = svd(E);
    W = [0 -1 0;1 0 0;0 0 1];
    
    tx = U * S * W * U';
    R = U * inv(W) * V';
    
    % Extract vector from tx (approximate)
    % crossmat_vector, approximate inverse of crossmat
    t = crossmat_vector(tx);
    
    % Fixing R...:
    
    %Cross[R[[All, #[[1]]]], R[[All, #[[2]]]]].R[[All, #[[3]]]] & /@ {{1, 
    %2, 3}, {2, 3, 1}, {3, 1, 2}}
    % all 1 for a rotation matrix
    if false
      if cross(R(:,1),R(:,2))' * R(:,3) < 0
          R(:,3) = -R(:,3);
          %'fixed R 3'
      end
      if cross(R(:,2),R(:,3))' * R(:,1) < 0
          R(:,1) = -R(:,1);
          %'fixed R 1'
      end
      if cross(R(:,3),R(:,1))' * R(:,2) < 0
          R(:,2) = -R(:,2);
          %'fixed R 2'
      end
    end
    
%    assert(cross(R(:,1),R(:,2))' * R(:,3) > 0)
    %assert(cross(R(:,2),R(:,3))' * R(:,1) > 0)
    %assert(cross(R(:,3),R(:,1))' * R(:,2) > 0)

    % Force R's column vectors to be a positively oriented basis...
    % Force R's vectors to lie in the same halfspace as the identity matrix' vectors.
    % This is not always strictly necessary -- 
    % if all axes are inverted, we are good
    
    for i = 1:3
        e = eye(3);
        if R(:,i)'*e(:,i) < 0
            R(:,i) = -R(:,i);
            %['post fixed implausible R', num2str(i)]
            %t = -t;
        end
    end
    
    % This holds for a rotation matrix
    assert(norm(R*R' - eye(3)) < 0.001);
    assert(cross(R(:,1),R(:,2))' * R(:,3) > 0)
    assert(cross(R(:,2),R(:,3))' * R(:,1) > 0)
    assert(cross(R(:,3),R(:,1))' * R(:,2) > 0)

    %assert(approximately_equal_up_to_scale(crossmat(t) * R, E, 0.4)); % yes, not very accurate...
    