function result_image = mesh_lerp_textured2d(verticesA, textureA, verticesB, textureB, triangles, factor)
    % linearly interpolates verticesA (defined over textureA) to verticesB
    % (defined over textureB). The triangulations have the same layout
    % given by triangles.
    % factor is in [0, 1] giving the linear interpolation amount
    %
    % vertices* is n x 2
    %  (fractional) coordinates on texture*
    % triangles is m x 3 integers >= 1 <= n indexing into vertices*
    %  as returned by e.g. delaunay
    % texture* is an image over which the vertices and triangles are
    % defined
    %
    % textureA and textureB have the same size, which is also the size of
    % the output
    
    output_size = size12(textureA);
    assert_equal(size12(textureB), output_size);
    assert(size(textureA,3) == size(textureB,3));
    
    result_vertices = (1-factor) .* verticesA + factor .* verticesB; % TODO is the formula x + s(y - x) faster?
    
    result_imageA = mesh_textured2d(result_vertices, verticesA, triangles, textureA, output_size);
    result_imageB = mesh_textured2d(result_vertices, verticesB, triangles, textureB, output_size);
    
    assert_same_size(result_imageA, result_imageB);
    
    result_image = (1-factor) .* result_imageA + factor .* result_imageB;