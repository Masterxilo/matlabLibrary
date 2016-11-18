function C = cconv2(A, h)
  % circular modulo convolution of matrix A with kernel h
  %
  % A is assumed to be a circulant matrix such that 
  % it can be convolved with h anywhere
  % 
  % A should be larger than or equal in dimensions to h (what happens
  % otherwise?).
  %
  % Note that by the convolution theorem
  % cconv2(A, h) == ifft2(fft2(A) .* fft2(h)) % TODO size of fft2 h needs
  % to be zero padded (?) to match size of A for this
  % TODO seems wrong with A = rand(3); h = rand(3);
  %
  % But performance characteristics may be different:
  % The left is O(n * m), the right is O(p log(p)) for p = max(n, m)
  % TODO plot these performance characteristics
  %
  % For separable filter kernels (those of the form k' * k for some row
  % vector k) the story is different yet again.
  % For a simple box filter (moving average), the size of the filter does
  % not even matter, see movingAverageCircular.
  %
  % TODO this is not implemented quite correctly: imfilter centers the
  % kernel (such that it may be used with fspecial results), but we should
  % not do this here. Have a look at filter2 too.
  % And https://en.wikipedia.org/wiki/Circular_convolution
  % It looks like for DFT the kernel and matrix cannot be treated equally:
  % the kernel has to be zero-padded, but the matrix made circular.
  
  assert(tensorRank(A) == 2);
  assert(tensorRank(h) == 2);
  
  %s = size(h)-1;
  %h2 = zeros(size(h) +
  %h = 
  C = imfilter(A, h, 'circular');