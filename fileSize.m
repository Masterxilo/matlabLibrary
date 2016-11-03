function fsize = fileSize(wdFileName)
    % returns the size in bytes of a file in the current working directory
    % or an absolute path
    % does not consider the full working path
    i = dir(wdFileName);
    fsize = i.bytes;
    