close all
imtool close all;	
uiwait(msgbox('Select corresponding points in the two images. Always select first a point in the left, then the corresponding point in the right image. Repeat about 20 times. Save often.'));
cps = cpselect(face1_1000(), face2_1000(),'Wait', true)