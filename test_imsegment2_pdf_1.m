% sanity check on 1x1 image
constant1 = @(x) 1;

label_image = imsegment2_pdf([0], [1]==1,[0]==1,constant1,constant1)

assert(all2(label_image == [0]));