close all
imshow_in_figure(bayerPattern(), 'bayerPattern')

data = [
        255, 0,   255, 0
        255, 255, 255, 255
        0,   0,   0,   0
        255, 0,   255, 0
    ] / 255.0;

imshow_in_figure(data, 'debayer input')


[maskR, maskG, maskB] = demosaicBayerMakeMasks(size(data));

% Apply
maskedR = maskR .* data;
maskedG = maskG .* data;
maskedB = maskB .* data;

imshow_in_figure_with_alpha(maskedR, maskR, 'debayer input r')
imshow_in_figure_with_alpha(maskedG, maskG, 'debayer input g')
imshow_in_figure_with_alpha(maskedB, maskB, 'debayer input b')
    
er = [255 255 255 255
127 127 127 127
000 000 000 000
000 000 000 000];

eg = [127 000 085 000
255 127 255 085
170 000 127 000
255 170 255 127];

eb = [255 255 255 255
255 255 255 255
127 127 127 127
000 000 000 000];

o = demosaicBayer(data);
imshow_in_figure(o, 'debayer output')
s = floor(o * 255);
assert_equal(s(:,:,1), er);
assert_equal(s(:,:,2), eg);
assert_equal(s(:,:,3), eb);


imshow_in_figure(o(:,:,1), 'debayer output r')
imshow_in_figure(o(:,:,2), 'debayer output g')
imshow_in_figure(o(:,:,3), 'debayer output b')