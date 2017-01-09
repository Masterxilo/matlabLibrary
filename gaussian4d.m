function gauss = gaussian4d(out_size, S)
  % unnormalized 4-dimensional gaussian
  %
  % Note that out_size should be large enough to
  % not lead to cropping of the kernel. 2 * ceil(sigma * 1.5) works well
  % but it depends on the shearing/scaling your matrix S will cause.
  % (Or 3* standard deviation..)
  %
  % The important point is that the values at the boundary should be very
  % small (i.e. the [ellipsoidal] lerp(min, max, 0.1)-isosurface of the resulting data
  % should not cross the boundary)
  
  gauss = normalize_integral(gaussian4d_unnormalized(out_size, S));