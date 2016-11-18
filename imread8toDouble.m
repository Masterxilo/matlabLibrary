function A = imread8toDouble(filename)
    % assumes filename is an 8 bit image and converts its colors to doubles
    % in [0,1]
    assert(isstring(filename));
    A = double(imread(filename)) / 255.0; % consider using im2double instead
    
    assert(isdouble(A) && isimage(A))