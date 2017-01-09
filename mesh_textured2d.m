function result_image = mesh_textured2d(vertices, texture_vertices, triangles, texture, output_size)
    % draws triangles given by [vertices, triangles], texturing them by
    % lookup & bilinear interpolation of triangles [texture_vertices, triangles]
    % on texture
    %
    % assumes nonoverlapping triangles
    %
    % Repeats the operation of triangle_rasterize2d for multiple triangles,
    % adding up the results.
    %
    % vertices & texture_vertices is n x 2
    %  (fractional) coordinates on texture or result_image (of output_size)
    % triangles is m x 3 integers >= 1 <= n indexing into vertices
    %  as returned by e.g. delaunay
    % texture is an image (any amount of channels) over which the [texture_vertices, triangles] are
    %  defined
    
    % mesh_textured_2d_impl2 ~ 10x faster than mesh_textured_2d_impl1
    result_image = mesh_textured_2d_impl2(vertices, texture_vertices, triangles, texture, output_size);
    
    