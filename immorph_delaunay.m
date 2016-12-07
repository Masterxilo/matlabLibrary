function morphed_image = immorph_delaunay(image1, points1, image2, points2, alpha)
    % morphs two images with marked corresponding points into each other
    % via triangulation (delaunay applied to points1) with linear interpolation
    % 
    % similar to http://www.learnopencv.com/face-morph-using-opencv-cpp-python/
    %
    % for Computational Photography Project 04
    %
    % points* are n x 2
    % Images must have the same size and color channel count.
    
    assert(size(points1, 2) == 2);
    assert(size(points2, 2) == 2);
    
    assert(alpha >= 0 && alpha <= 1);
    assert_same_size(image1, image2);
    assert_same_size(points1, points2);

    triangles = delaunay(points1);

    morphed_image = mesh_lerp_textured2d(points1, image1, points2, image2, triangles, alpha);