function A = imread8toDouble(filename)
    % assumes filename is an 8 bit image and converts its colors to doubles
    % in [0,1]
    A = double(imread(filename)) / 255.0;