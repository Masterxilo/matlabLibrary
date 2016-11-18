function imsegment2_demo_sub(image, foreground, background, gmm_components)

    close all

    imshow_in_figure(image, 'GraphCut image segmentation: Base image');
    imshow_in_figure(foreground, 'GraphCut image segmentation: Foreground mask');
    imshow_in_figure(background, 'GraphCut image segmentation: Background mask');

    if nargin == 3
        gmm_components = 3;
    end
    labels = imsegment2(image, foreground, background, gmm_components); % 3 = gmm components
    
    imshow_in_figure(immask(image, 1-labels), 'GraphCut image segmentation: Computed Foreground');
    imshow_in_figure(immask(image, labels), 'GraphCut image segmentation: Computed Background');
    imshow_in_figure(labels, 'GraphCut image segmentation: Computed Labels');