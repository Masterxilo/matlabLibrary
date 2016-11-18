function fsize = imfsize(filename)
    % Image File Size
    % Gives the size in bytes (byte count) of an image file anywhere on the path
    i = imfinfo(filename);
    fsize = i.FileSize;