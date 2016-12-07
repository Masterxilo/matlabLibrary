function H = homography2d_impl3(p, q)
  % implementation from http://www.robots.ox.ac.uk/~vgg/hzbook/code/
  
  H = vgg_H_from_x_lin(p, q);