function out = fake_gamma_compression(in, a)
    % c.f. custom gamma compression.nb
    % this can be applied to forward difference gradients
    % to downscale large gardients while preserving small ones
    % a is the scale given to sqrt(2)-length gradients (maximum)
    % 0.2 works well
    %
    % This uses a spline interpolation
    
    x = norm(in(:));
    assert(x >= 0 && x <= sqrt(2));
    assert(a >= 0 && a <= sqrt(2));
    
    if a > sqrt(2)/2
        s = 2.*a.*(a.*((-1).*2.^(1/2)+2.*a).^(-1)+(-1).*(((-1).*2.^(1/2)+2.*a) ...
  .^(-2).*(a.^2+2.^(1/2).*x+(-2).*a.*x)).^(1/2))+(-1).*a.*(a.*((-1) ...
  .*2.^(1/2)+2.*a).^(-1)+(-1).*(((-1).*2.^(1/2)+2.*a).^(-2).*(a.^2+ ...
  2.^(1/2).*x+(-2).*a.*x)).^(1/2)).^2;
    else % todo undefined for sqrt(2)/2 exactly, but that is not representable anyho
        s = 2.*a.*(a.*((-1).*2.^(1/2)+2.*a).^(-1)+(((-1).*2.^(1/2)+2.*a).^(-2) ...
  .*(a.^2+2.^(1/2).*x+(-2).*a.*x)).^(1/2))+(-1).*a.*(a.*((-1).*2.^( ...
  1/2)+2.*a).^(-1)+(((-1).*2.^(1/2)+2.*a).^(-2).*(a.^2+2.^(1/2).*x+( ...
  -2).*a.*x)).^(1/2)).^2;
    end
    
    if x > 0.00001
        out = s/x * in;
    else
        out = in;
    end