function fsize = imfsize(filename)
    % gives the size in bytes of an image file anywhere on the path
    i = imfinfo(filename);
    fsize = i.FileSize;