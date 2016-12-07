i1 = (imreaddouble('panorama2_left.jpg')); % 'panorama(1|2)_left.jpg'
i2 = (imreaddouble('panorama2_right.jpg')); % 'panorama(1|2)_left.jpg'

h1to2 = [
    1.0000   -0.0453 -720.0167
    0.1139    0.9449  -82.5851
    0.0002   -0.0000    0.7741
    ];
  
% compute an appropriate bounding box for the target image
p1 = image_vertices(i1)
p1t = homography_transform(h1to2, p1)  
pa = [p1 p1t]

aabbi = bounding_box_int_overestimate_dn(pa); % [aa bb]
o__wh = bounding_box_dn_to_rectangle(aabbi); % [x y w h]

es = [1 imageWidth(i1) 1 imageHeight(i1)]
et = reshape(aabbi', 1, 4) % target coordinate bounds [xmin xmax ymin ymax]

% compute transformed images
it = imtransform_bilinear_homography(i1, inv(h1to2), es, et, o__wh([4 3]));
it2 = imtransform_bilinear_homography(i2, eye(3), es, et, o__wh([4 3]));

imshow_in_figure(it, 'it');
imshow_in_figure(it2, 'it2');
imshow_in_figure(imfillholes(it, it2), 'imfillholes');


