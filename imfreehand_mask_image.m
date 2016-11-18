function mask = imfreehand_mask_image(image)
    % display a crude GUI on top of image to allow user to draw a binary
    % maks of the same size of the region to indicate a set of pixels on
    % the image.
    
    mask = zeros(imageHeight(image), imageWidth(image));
    
message = sprintf('Left click and hold to begin drawing one connected part of the region.\nSimply lift the mouse button to finish');
        uiwait(msgbox(message));
        
    while 1
        % Creating a binary mask using imfreehand:
        % https://ch.mathworks.com/matlabcentral/newsreader/view_thread/287560
        close all
        imtool close all;	
        workspace;	% Make sure the workspace panel is showing.
        imshow(image)

        set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
        hFH = imfreehand();

        % Create a binary image ("mask") from the ROI object.
        binaryImage = hFH.createMask();
        % Display the freehand mask.
        mask = mask + binaryImage;
        imshow(mask);
        title('Binary mask of the region');
        
        choice = questdlg('Do you want to draw further sub-regions of the mask?', 'More?', 'Yes', 'No', 'No');
% Handle response
switch choice
    case 'yes'
        continue
    case 'No'
        break
end

if 0
        uiwait(msgbox('Type "1" to further extend the region: '));
        more = input('Type "1" to further extend the region: ');
        if more
            continue
        else
            break
        end
end
    end
    
    mask = mask == 1; % to logical