function [mask, colorImages] = CV01_readMaskAndColorImages(imgbase)
  %imgbase = '../images/owl/owl'; or ps.owl
  mask=imread_logical([imgbase '.mask.png']);
  colorImages=imreaddouble_multiple_numbered0(imgbase);