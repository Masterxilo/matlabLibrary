i=imreaddouble('Bayer_Demosaic_VandewalleKAS07_data_testimage_1.tif');
close all
imshow_in_figure(demosaicBayerMedian(i),'demosaicBayerMedian')

imshow_in_figure(demosaicBayer(i),'demosaicBayer')